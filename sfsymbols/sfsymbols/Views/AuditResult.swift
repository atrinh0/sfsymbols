//
//  AuditResult.swift
//  sfsymbols
//
//  Created by An Trinh on 2/8/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct AuditResult: View {
    @ObservedObject var model: SymbolModel
    @Binding var showingAudit: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: { showingAudit = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .navButtonStyle()
                        .padding()
                }
                .pressableButton()
            }
            let symbols = model.symbols(for: .defaultOrder, filter: "")
            let notFound: [String] = symbols.compactMap { UIImage(systemName: $0.name) == nil ? $0.name : nil }
            VStack(alignment: .leading, spacing: 10) {
                Text("🧐")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                Text("Total SF Symbols count: \(symbols.count)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Missing symbols: \(notFound.count)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            List(notFound, id: \.self) { symbol in
                Text(symbol)
            }
        }
    }
}

struct AuditResult_Previews: PreviewProvider {
    static var previews: some View {
        AuditResult(model: SymbolModel(), showingAudit: .constant(true))
    }
}
