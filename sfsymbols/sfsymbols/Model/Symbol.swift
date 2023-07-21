//
//  Symbol.swift
//  sfsymbols
//
//  Created by An Trinh on 28/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import Foundation

struct Symbol: Hashable, Identifiable {
    let name: String
    let isMulticolor: Bool
    let isVariable: Bool

    var id: String {
        name
    }
}
