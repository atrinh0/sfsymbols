//
//  SymbolList.swift
//  sfsymbols
//
//  Created by An Trinh on 9/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI
import UIKit
import CoreHaptics

struct SymbolList: View {
    @ObservedObject var model: SymbolModel
    
    @State private var searchText = ""
    @State private var showSortOptions = false
    @State private var sortOrder: SortOrder = .defaultOrder
    @State private var showingDetails = false

    private let layout = [
        GridItem(.adaptive(minimum: 100), alignment: .top)
    ]
    
    var pluralizer: String { filteredSymbols(searchText).count == 1 ? "" : "s" }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    searchBar
                    HStack {
                        Text("\(filteredSymbols(searchText).count) symbol\(pluralizer)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                    LazyVGrid(columns: layout, spacing: 16) {
                        ForEach(filteredSymbols(searchText), id: \.self) { symbol in
                            Button(action: { select(symbol) }) {
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
                    Button(action: { showSortOptions.toggle() }) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .imageScale(.large)
                            .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showingDetails) {
            SymbolDetail(model: model, showingDetails: $showingDetails)
        }
        .actionSheet(isPresented: $showSortOptions) {
            ActionSheet(title: Text("Sort by"), message: nil, buttons: [
                .default(Text("Default"), action: { sortOrder = .defaultOrder }),
                .default(Text("Name"), action: { sortOrder = .name }),
                .default(Text("Multicolored"), action: { sortOrder = .multicolored }),
                .cancel()
            ]
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var searchBar: some View {
        HStack {
            TextField("Search", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(Color.primary)
                .frame(height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    UIApplication.shared.windows.first?.endEditing(true)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.primary)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func filteredSymbols(_ searchText: String) -> [Symbol] {
        return model.symbols(for: sortOrder, filter: searchText)
    }
    
    private func select(_ symbol: Symbol) {
        UIApplication.shared.windows.first?.endEditing(true)
        model.select(symbol)
        hapticBump()
        showingDetails = true
    }
    
    private func hapticBump() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolList(model: SymbolModel())
    }
}


