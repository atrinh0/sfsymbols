//
//  SymbolList.swift
//  sfsymbols
//
//  Created by An Trinh on 9/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI
import UIKit
import CoreHaptics

struct SymbolList: View {
    @ObservedObject var model: SymbolModel

    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .defaultOrder
    @State private var showingDetails = false
    @State private var showingAudit = false

    private let layout = [GridItem(.adaptive(minimum: 100), alignment: .top)]

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    symbolsCount
                    symbolsGrid
                }
                .searchable(text: $searchText)
            }
            .navigationBarTitle("SF Symbols", displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $sortOrder, label: Text("Sort")) {
                            ForEach(SortOrder.allCases, id: \.self) { order in
                                Text(order.rawValue).tag(order)
                            }
                        }
                        Divider()
                        Button {
                            showingAudit = true
                        } label: {
                            Text("Run Audit...")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .navButtonStyle()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingDetails) {
            SymbolDetail(model: model)
        }
        .sheet(isPresented: $showingAudit) {
            AuditResult(model: model)
        }
    }

    // MARK: - Subviews

    private var symbolsCount: some View {
        HStack {
            Text("^[\(filteredSymbols(searchText).count) symbol](inflect: true)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
        .padding()
    }

    private var symbolsGrid: some View {
        LazyVGrid(columns: layout, spacing: 16) {
            ForEach(filteredSymbols(searchText), id: \.self) { symbol in
                Button {
                    select(symbol)
                } label: {
                    SymbolCell(symbol: symbol, isFocused: false)
                        .contextMenu {
                            Button {
                                select(symbol)
                            } label: {
                                Text("Enlarge")
                                Image(systemName: "arrow.up.left.and.arrow.down.right")
                            }
                            Button {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = symbol.name
                            } label: {
                                Label("Copy Name", systemImage: "doc.on.doc")
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Helpers

    private func filteredSymbols(_ searchText: String) -> [Symbol] {
        return model.symbols(for: sortOrder, filter: searchText)
    }

    private func select(_ symbol: Symbol) {
        model.select(symbol)
        hapticBump()
        showingDetails = true
    }

    private func hapticBump() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolList(model: SymbolModel())
    }
}
