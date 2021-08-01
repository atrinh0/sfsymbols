//
//  SFSymbolsApp.swift
//  sfsymbols
//
//  Created by An Trinh on 9/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI

@main
struct SFSymbolsApp: App {
    @StateObject private var model = SymbolModel()

    var body: some Scene {
        WindowGroup {
            SymbolList(model: model)
        }
    }
}
