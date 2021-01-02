//
//  SymbolDetail.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolDetail: View {
    @ObservedObject var model: SymbolModel
    let closeAction: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: closeAction) {
                    Image(systemName: "xmark.circle.fill")
                        .navButtonStyle()
                        .padding()
                }
                .pressableButton()
            }
            Spacer()
            SymbolCell(symbol: model.selectedSymbol, isFocused: true)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(model: SymbolModel(), closeAction: { })
    }
}
