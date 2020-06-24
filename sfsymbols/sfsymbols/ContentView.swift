//
//  ContentView.swift
//  sfsymbols
//
//  Created by An Trinh on 9/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI

let cellWidth: CGFloat = 150

struct ContentView: View {
    @State private var searchText = ""
    
    @State private var showSortOptions = false
    @State private var sortOrder: SortOrder = .defaultOrder
    
    @State private var showingDetails = false
    @State private var focusedSymbol = ""
    
    enum SortOrder: String {
        case defaultOrder = "Default"
        case name = "Name"
    }
    
    let layout = [
        GridItem(.adaptive(minimum: cellWidth), alignment: .top)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
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
                    LazyVGrid(columns: layout, spacing: 16) {
                        ForEach(filteredSymbols(searchText), id: \.self) { symbol in
                            Button(action: {
                                focusedSymbol = symbol
                                withAnimation() {
                                    showingDetails.toggle()
                                }
                            }) {
                                SymbolCell(symbol: symbol)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                ZStack {
                    VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        VStack(spacing: 0) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(white: 0.1))
                                    .frame(width: cellWidth, height: 156)
                                Image(systemName: focusedSymbol)
                                    .renderingMode(.original)
                                    .imageScale(.large)
                                    .scaleEffect(3.5)
                            }
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(white: 0.9))
                                    .frame(width: cellWidth, height: 156)
                                Image(systemName: focusedSymbol)
                                    .renderingMode(.original)
                                    .imageScale(.large)
                                    .scaleEffect(3.5)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                        Text(focusedSymbol)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .frame(width: cellWidth * 2)
                    }
                }
                .opacity(showingDetails ? 1 : 0)
                .onTapGesture {
                    withAnimation() {
                        showingDetails = false
                    }
                }
            }
            .navigationBarTitle("SF Symbols", displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSortOptions.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .imageScale(.large)
                            .padding()
                    }
                }
            }
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
    
    func filteredSymbols(_ searchText: String) -> [String] {
        var filteredSymbols = symbols()
        if !searchText.isEmpty {
            filteredSymbols = symbols().filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        return filteredSymbols
    }
    
    func symbols() -> [String] {
        return sortOrder == .defaultOrder ? symbolsSortedByDefault : symbolsSortedByName
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //            .colorScheme(.dark)
    }
}

struct SymbolCell: View {
    let symbol: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(white: 0.1))
                        .frame(width: cellWidth/2, height: 78)
                    Image(systemName: symbol)
                        .renderingMode(.original)
                        .imageScale(.large)
                        .scaleEffect(1.75)
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(white: 0.9))
                        .frame(width: cellWidth/2, height: 78)
                    Image(systemName: symbol)
                        .renderingMode(.original)
                        .imageScale(.large)
                        .scaleEffect(1.75)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            Text(symbol)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: cellWidth)
        }
    }
}
