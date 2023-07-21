//
//  Filter.swift
//  sfsymbols
//
//  Created by An Trinh on 20/08/2022.
//  Copyright © 2022 An Trinh. All rights reserved.
//

import SwiftUI

enum Filter: String, CaseIterable {
    case all = "All"
    case multicolor = "Multicolor"
    case variable = "Variable Color"
}

extension Filter {
    var menuSymbol: String {
        let symbolMap: [Filter: String] = [
            .all: "square.grid.2x2",
            .multicolor: "paintpalette",
            .variable: "slider.horizontal.below.square.and.square.filled"
        ]
        return symbolMap[self] ?? ""
    }
}
