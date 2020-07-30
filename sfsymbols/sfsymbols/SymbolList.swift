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
                                    .contextMenu {
                                        Button(action: {
                                            select(symbol)
                                        }) {
                                            Text("Enlarge")
                                            Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                                        }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationBarTitle("SF Symbols", displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu() {
                        ForEach(SortOrder.allCases, id: \.self) { order in
                            Button(action: { sortOrder = order }) {
                                Text(order.rawValue)
                                if sortOrder == order {
                                    Image(systemName: "checkmark")
                                        .font(Font.body.bold())
                                        .foregroundColor(Color.primary.opacity(0.7))
                                }
                            }
                        }
                    }
                    label: {
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
                            .navButtonStyle()
                    }
                }
            }
        }
        .sheet(isPresented: $showingDetails) {
            SymbolDetail(model: model, showingDetails: $showingDetails)
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
                .pressableButton()
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


