//
//  ContentView.swift
//  sfsymbols
//
//  Created by An Trinh on 9/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolsListView: View {
    @State private var searchText = ""

    @State private var showSortOptions = false
    @State private var sortOrder: SortOrder = .defaultOrder

    @State private var showingDetails = false
    @State private var focusedSymbol = ""

    private enum SortOrder: String {
        case defaultOrder = "Default"
        case name = "Name"
    }

    private let layout = [GridItem(.adaptive(minimum: 100), alignment: .top)]

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    HStack {
                        TextField("Search", text: $searchText)
                            .disableAutocorrection(true)
                            .foregroundColor(.primary)
                            .frame(height: 50)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                                UIApplication.shared.windows.first?.endEditing(true)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.horizontal)
                    LazyVGrid(columns: layout, spacing: 16) {
                        ForEach(filteredSymbols(searchText), id: \.self) { symbol in
                            Button {
                                UIApplication.shared.windows.first?.endEditing(true)
                                focusedSymbol = symbol
                                showingDetails = true
                            } label: {
                                SymbolCell(symbol: symbol, isFocused: false)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationBarTitle("SF Symbols", displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSortOptions.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .imageScale(.large)
                            .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showingDetails) {
            DetailView(showingDetails: $showSortOptions, symbol: focusedSymbol)
        }
        .actionSheet(isPresented: $showSortOptions) {
            ActionSheet(title: Text("Sort by"), message: nil, buttons: [
                .default(Text("Default"), action: { sortOrder = .defaultOrder }),
                .default(Text("Name"), action: { sortOrder = .name }),
                .cancel()
            ]
            )
        }
    }

    private func filteredSymbols(_ searchText: String) -> [String] {
        var filteredSymbols = symbols()
        if !searchText.isEmpty {
            filteredSymbols = symbols().filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        return filteredSymbols
    }

    private func symbols() -> [String] {
        return sortOrder == .defaultOrder ? symbolsSortedByDefault : symbolsSortedByName
    }

    private func isMulticolor(symbol: String) -> Bool {
        return multicolorSymbols.contains(symbol)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsListView()
    }
}
