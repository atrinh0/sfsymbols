//
//  SymbolModel.swift
//  sfsymbols
//
//  Created by An Trinh on 28/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

enum SortOrder {
    case defaultOrder
    case name
    case multicolored
}

class SymbolModel: ObservableObject {
    private var symbolsSortedByDefault: [String] = []
    private var symbolsSortedByName: [String] = []
    private var multicolorSymbols: [String] = []

    init() {
        loadSymbols()
    }
    
    func symbols(for sortOrder: SortOrder) -> [Symbol] {
        var symbols: [String] = []
        switch sortOrder {
        case .defaultOrder: symbols = symbolsSortedByDefault
        case .name: symbols = symbolsSortedByName
        case .multicolored: symbols = multicolorSymbols
        }
        return symbols.map { Symbol(name: $0, isMulticolored: multicolorSymbols.contains($0)) }
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
