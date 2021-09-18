//
//  AuditResult.swift
//  sfsymbols
//
//  Created by An Trinh on 2/8/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct AuditResult: View {
    let model: SymbolModel
    private var symbolsNotFound: [String] = []

    @Environment(\.dismiss) var dismiss

    init(model: SymbolModel) {
        self.model = model
        symbolsNotFound = model.symbols(for: .defaultOrder)
            .filter { UIImage(systemName: $0.name) == nil }
            .map { $0.name }
    }

    var body: some View {
        VStack(alignment: .leading) {
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
            VStack(alignment: .leading, spacing: 10) {
                Text("🧐")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                Text("Total SF Symbols count: \(totalCount)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Missing symbols: \(symbolsNotFound.count)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            List(symbolsNotFound, id: \.self) { symbol in
                Text(symbol)
            }
            .listStyle(.plain)
        }
    }

    private var totalCount: Int {
        model.symbols(for: .defaultOrder).count
    }
}

struct AuditResult_Previews: PreviewProvider {
    static var previews: some View {
        AuditResult(model: SymbolModel())
    }
}
