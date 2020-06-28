//
//  SymbolCell.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolCell: View {
    let symbol: Symbol
    let isFocused: Bool

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: isFocused ? 24 : 8, style: .continuous)
                    .foregroundColor(Color.secondary.opacity(0.25))
                    .frame(width: isFocused ? 300 : 100, height: isFocused ? 234 : 78)
                if symbol.isMulticolored {
                    #warning("🧐 Workaround for multicolor not coloring when setting font size")
                    #warning("🤔 Note that dynamic text size also affects colors (default being most successful)")
                    #warning("💭 Also iPhone 11 simulator appears to be more successful than the other devices")
                    Image(systemName: symbol.name)
                        .renderingMode(.original)
                        .imageScale(.large)
                        .scaleEffect(isFocused ? 5.25 : 1.75)
                } else {
                    Image(systemName: symbol.name)
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                        .imageScale(.large)
                        .font(.system(size: isFocused ? 90 : 30))
                }
            }
            Text(symbol.name)
                .font(isFocused ? .largeTitle : .caption)
                .multilineTextAlignment(.center)
                .lineLimit(isFocused ? .none : 2)
                .frame(width: isFocused ? 300 : 100)
        }
    }
}

struct SymbolCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SymbolCell(symbol: Symbol(name: "leaf.fill", isMulticolored: true), isFocused: false)
            SymbolCell(symbol: Symbol(name: "leaf.fill", isMulticolored: true), isFocused: true)
        }
    }
}
