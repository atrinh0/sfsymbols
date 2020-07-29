//
//  SymbolModel.swift
//  sfsymbols
//
//  Created by An Trinh on 28/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

enum SortOrder: String, CaseIterable {
    case defaultOrder = "Sorted by Default"
    case name = "Sorted by Name"
    case multicolored = "Multicolored Only"
}

class SymbolModel: ObservableObject {
    private var symbolsSortedByDefault: [String] = []
    private var symbolsSortedByName: [String] = []
    private var multicolorSymbols: [String] = []
    
    @Published var selectedSymbol: Symbol = Symbol(name: "leaf.fill", isMulticolored: true)

    init() {
        loadSymbols()
    }
    
    func symbols(for sortOrder: SortOrder, filter: String) -> [Symbol] {
        var symbols: [String] = []
        switch sortOrder {
        case .defaultOrder: symbols = symbolsSortedByDefault
        case .name: symbols = symbolsSortedByName
        case .multicolored: symbols = multicolorSymbols
        }
        return symbols.compactMap {
            if filter.isEmpty || $0.lowercased().contains(filter.lowercased()) {
                return Symbol(name: $0, isMulticolored: multicolorSymbols.contains($0))
            } else {
                return nil
            }
        }
    }
    
    func select(_ symbol: Symbol) {
        selectedSymbol = symbol
    }
}

extension SymbolModel {
    private func loadSymbols() {
        symbolsSortedByDefault = symbolsFromFile(name: "SymbolsSortedByDefault")
        symbolsSortedByName = symbolsFromFile(name: "SymbolsSortedByName")
        multicolorSymbols = symbolsFromFile(name: "MulticolorSymbols")
    }
    
    private func symbolsFromFile(name: String) -> [String] {
        if let fileURL = Bundle.main.url(forResource: name, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                return fileContents.split(separator: "\n").compactMap { $0.isEmpty ? nil : String($0) }
            }
        }
        return []
    }
}
