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
    let isMulticolored: Bool
    let id = UUID() // swiftlint:disable:this identifier_name
}
