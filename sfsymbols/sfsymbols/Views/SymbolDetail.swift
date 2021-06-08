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
    @State private var showCopied = false
    
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
                .frame(maxHeight: 15)
            VStack {
            if showCopied {
                Text("👍🏻 Copied")
            } else {
                Button(action: {
                    copyName()
                }) {
                    Label("Copy Name", systemImage: "doc.on.doc")
                }
                .controlProminence(.increased)
                .buttonStyle(.bordered)
                .tint(.accentColor)
            }
            }
            .frame(minHeight: 44)
            Spacer()
        }
    }
    
    private func copyName() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = model.selectedSymbol.name
        
        withAnimation {
            showCopied = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showCopied = false
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(model: SymbolModel(), closeAction: { })
    }
}
