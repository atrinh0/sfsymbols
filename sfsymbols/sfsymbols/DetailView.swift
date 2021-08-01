//
//  FocusedView.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct FocusedView: View {
    @Binding var showingDetails: Bool
    let symbol: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showingDetails = false
                } label: {
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
        FocusedView(showingDetails: .constant(true), symbol: "leaf.fill")
    }
}
