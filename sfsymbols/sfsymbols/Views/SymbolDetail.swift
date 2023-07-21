//
//  SymbolDetail.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolDetail: View {
    let symbol: Symbol
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .navButtonStyle()
                        .padding()
                }
                .pressableButton()
            }
            Spacer()
            SymbolCell(symbol: symbol, isFocused: true)
            Spacer()
        }
    }
}

#Preview {
    SymbolDetail(symbol: Symbol(name: "leaf", isMulticolor: true, isVariable: false))
}
