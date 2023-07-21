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

    @State private var variableValue = 0.0
    @State private var isAscending = true
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: isFocused ? 24 : 8, style: .continuous)
                    .foregroundColor(.secondary.opacity(0.25))
                    .frame(width: isFocused ? 300 : 100, height: isFocused ? 234 : 78)
                Image(systemName: symbol.name, variableValue: safeVariableValue)
                    .renderingMode(symbol.isMulticolor ? .original : .template)
                    .foregroundColor(symbol.isMulticolor ? .secondary : .primary)
                    .imageScale(.large)
                    .font(.system(size: isFocused ? 90 : 30))
                    .symbolEffect(.bounce, value: isAscending)
            }
            Text(symbol.name)
                .font(isFocused ? .largeTitle : .caption)
                .multilineTextAlignment(.center)
                .lineLimit(isFocused ? .none : 2)
                .textSelection(.enabled)
                .frame(width: isFocused ? 300 : 100)
        }
        .onReceive(timer) { _ in
            variableTimerTick()
        }
        .onAppear {
            if !symbol.isVariable {
                timer.upstream.connect().cancel()
            }
        }
    }

    private func variableTimerTick() {
        var newValue = variableValue
        if isAscending {
            newValue += 0.05
        } else {
            newValue -= 0.05
        }

        // allow going beyond bounds to pause at each end
        if newValue > 1.25 {
            isAscending = false
        } else if newValue < -0.25 {
            isAscending = true
        }

        variableValue = newValue
    }

    private var safeVariableValue: Double {
        min(max(0, variableValue), 1)
    }
}

struct SymbolCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SymbolCell(symbol: Symbol(name: "leaf.fill", isMulticolor: true, isVariable: false), isFocused: false)
            SymbolCell(symbol: Symbol(name: "leaf.fill", isMulticolor: true, isVariable: false), isFocused: true)
        }
    }
}
