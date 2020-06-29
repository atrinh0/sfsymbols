//
//  SymbolDetail.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolDetail: View {
    @EnvironmentObject private var model: SymbolModel
    @Binding var showingDetails: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { showingDetails = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(Font.title2.bold())
                        .imageScale(.large)
                        .padding()
                        .foregroundColor(Color.primary.opacity(0.7))
                }
            }
            Spacer()
            SymbolCell(symbol: model.selectedSymbol, isFocused: true)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(showingDetails: .constant(true))
            .environmentObject(SymbolModel())
    }
}
