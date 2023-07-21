//
//  SymbolModel.swift
//  sfsymbols
//
//  Created by An Trinh on 28/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

class SymbolModel {
    private var allSymbols: [Symbol] = []
    private var multicolorSymbols: [Symbol] = []
    private var variableSymbols: [Symbol] = []

    init() {
        loadSymbols()
    }

    func symbols(for selectedFilter: Filter, searchQuery: String = "") -> [Symbol] {
        let symbolsMap: [Filter: [Symbol]] = [.all: allSymbols,
                                              .multicolor: multicolorSymbols,
                                              .variable: variableSymbols]
        let symbols = symbolsMap[selectedFilter] ?? []
        if searchQuery.isEmpty {
            return symbols
        }

        return symbols.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    }
}

extension SymbolModel {
    private func loadSymbols() {
        let allStrings = symbolsFromFile(name: "AllSymbols")
        let multicolorStrings = symbolsFromFile(name: "MulticolorSymbols")
        let variableStrings = symbolsFromFile(name: "VariableSymbols")

        allSymbols = allStrings.map {
            Symbol(name: $0, isMulticolor: multicolorStrings.contains($0), isVariable: variableStrings.contains($0))
        }
        multicolorSymbols = multicolorStrings.map {
            Symbol(name: $0, isMulticolor: true, isVariable: variableStrings.contains($0))
        }
        variableSymbols = variableStrings.map {
            Symbol(name: $0, isMulticolor: multicolorStrings.contains($0), isVariable: true)
        }
    }

    private func symbolsFromFile(name: String) -> [String] {
        guard let fileURL = Bundle.main.url(forResource: name, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL)
        else {
                  return []
        }
        return fileContents.split(separator: "\n").compactMap { $0.isEmpty ? nil : String($0) }
    }
}
