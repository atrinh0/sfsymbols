//
//  SymbolDetail.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolDetail: View {
    @Binding var showingDetails: Bool
    let symbol: Symbol
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showingDetails = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(Font.title.bold())
                        .imageScale(.large)
                        .padding()
                        .foregroundColor(Color.primary)
                }
            }
            Spacer()
            SymbolCell(symbol: symbol, isFocused: true)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(showingDetails: .constant(true), symbol: Symbol(name: "leaf.fill", isMulticolored: true))
    }
}
