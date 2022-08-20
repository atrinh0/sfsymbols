//
//  SortOrder.swift
//  sfsymbols
//
//  Created by An Trinh on 20/08/2022.
//  Copyright © 2022 An Trinh. All rights reserved.
//

import SwiftUI

enum SortOrder: String, CaseIterable {
    case defaultOrder = "Sorted by Default"
    case name = "Sorted by Name"
    case multicolored = "Multicolored Only"
    case variable = "Variable Only"
}

extension SortOrder {
    var menuSymbol: String {
        let symbolMap: [SortOrder: String] = [
            .defaultOrder: "line.3.horizontal.decrease",
            .name: "textformat.abc",
            .multicolored: "paintbrush.pointed.fill",
            .variable: "rays"
        ]
        return symbolMap[self] ?? ""
    }
}
