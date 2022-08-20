//
//  SymbolModel.swift
//  sfsymbols
//
//  Created by An Trinh on 28/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

class SymbolModel {
    private var symbolsSortedByDefault: [Symbol] = []
    private var symbolsSortedByName: [Symbol] = []
    private var multicolorSymbols: [Symbol] = []
    private var variableSymbols: [Symbol] = []

    init() {
        loadSymbols()
    }

    func symbols(for sortOrder: SortOrder, filter: String = "") -> [Symbol] {
        let symbolsMap: [SortOrder: [Symbol]] = [.defaultOrder: symbolsSortedByDefault,
                                                 .name: symbolsSortedByName,
                                                 .multicolored: multicolorSymbols,
                                                 .variable: variableSymbols]
        let symbols = symbolsMap[sortOrder] ?? []
        if filter.isEmpty {
            return symbols
        }

        return symbols.filter { $0.name.lowercased().contains(filter.lowercased()) }
    }
}

extension SymbolModel {
    private func loadSymbols() {
        let defaultOrderStrings = symbolsFromFile(name: "SymbolsSortedByDefault")
        let nameStrings = symbolsFromFile(name: "SymbolsSortedByName")
        let multicoloredStrings = symbolsFromFile(name: "MulticolorSymbols")
        let variableStrings = symbolsFromFile(name: "VariableSymbols")

        symbolsSortedByDefault = defaultOrderStrings.map {
            Symbol(name: $0, isMulticolored: multicoloredStrings.contains($0), isVariable: variableStrings.contains($0))
        }
        symbolsSortedByName = nameStrings.map {
            Symbol(name: $0, isMulticolored: multicoloredStrings.contains($0), isVariable: variableStrings.contains($0))
        }
        multicolorSymbols = multicoloredStrings.map {
            Symbol(name: $0, isMulticolored: true, isVariable: variableStrings.contains($0))
        }
        variableSymbols = variableStrings.map {
            Symbol(name: $0, isMulticolored: multicoloredStrings.contains($0), isVariable: true)
        }
    }

    private func symbolsFromFile(name: String) -> [String] {
        guard let fileURL = Bundle.main.url(forResource: name, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
                  return []
        }
        return fileContents.split(separator: "\n").compactMap { $0.isEmpty ? nil : String($0) }
    }
}
