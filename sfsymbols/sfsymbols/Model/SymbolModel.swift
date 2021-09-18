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

class SymbolModel {
    private var symbolsSortedByDefault: [Symbol] = []
    private var symbolsSortedByName: [Symbol] = []
    private var multicolorSymbols: [Symbol] = []

    init() {
        loadSymbols()
    }

    func symbols(for sortOrder: SortOrder, filter: String = "") -> [Symbol] {
        let symbolsMap: [SortOrder: [Symbol]] = [.defaultOrder: symbolsSortedByDefault,
                                                 .name: symbolsSortedByName,
                                                 .multicolored: multicolorSymbols]
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

        symbolsSortedByDefault = defaultOrderStrings.map {
            Symbol(name: $0, isMulticolored: multicoloredStrings.contains($0))
        }
        symbolsSortedByName = nameStrings.map {
            Symbol(name: $0, isMulticolored: multicoloredStrings.contains($0))
        }
        multicolorSymbols = defaultOrderStrings.map {
            Symbol(name: $0, isMulticolored: true)
        }
    }

    private func symbolsFromFile(name: String) -> [String] {
        guard let  fileURL = Bundle.main.url(forResource: name, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
                  return []
        }
        return fileContents.split(separator: "\n").compactMap { $0.isEmpty ? nil : String($0) }
    }
}
