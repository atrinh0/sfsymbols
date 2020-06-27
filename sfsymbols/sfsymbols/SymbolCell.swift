//
//  SymbolCell.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolCell: View {
    let symbol: String
    let isFocused: Bool

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: isFocused ? 16 : 8, style: .continuous)
                        .foregroundColor(Color.secondary.opacity(0.25))
                        .frame(width: isFocused ? 200 : 100, height: isFocused ? 156 : 78)
                    Image(systemName: symbol)
                        .renderingMode(isMulticolor ? .original : .template)
                        .foregroundColor(isMulticolor ? .none : .primary)
                        .imageScale(.large)
                        .font(isMulticolor ? .none : .system(size: isFocused ? 60 : 30))
                        .scaleEffect(isMulticolor ? (isFocused ? 3.5 : 1.75) : 1)
                }
            }
            Text(symbol)
                .font(isFocused ? .largeTitle : .caption)
                .multilineTextAlignment(.center)
                .lineLimit(isFocused ? .none : 2)
                .frame(width: isFocused ? 300 : 100)
        }
    }
    
    private var isMulticolor: Bool {
        return multicolorSymbols.contains(symbol)
    }
}

struct SymbolCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SymbolCell(symbol: "leaf.fill", isFocused: false)
            SymbolCell(symbol: "leaf.fill", isFocused: true)
        }
    }
}
