//
//  ContentView.swift
//  sfsymbols
//
//  Created by An Trinh on 9/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var darkMode = true
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: HStack {
                    TextField("Search", text: $searchText)
                        .foregroundColor(Color.primary)
                        .padding()
                    if !searchText.isEmpty {
                        Button(action: {
                            self.searchText = ""
                            UIApplication.shared.windows.first?.endEditing(true)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(Color.primary)
                                .padding()
                        }
                    }
                }) {
                    ForEach(filteredSymbols(self.searchText), id: \.self) { symbol in
                        HStack {
                            Image(systemName: symbol)
                                .imageScale(.large)
                                .frame(width: 40, height: 40)
                            Text(symbol)
                                .font(.headline)
                                .bold()
                        }
                    }
                }
            }
            .navigationBarTitle("SF Symbols", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                self.darkMode.toggle()
                self.reloadDarkMode(self.darkMode)
            }) {
                Image(systemName: self.darkMode ? "sun.max.fill" : "moon.circle.fill")
                    .imageScale(.large)
            })
        }
        .onAppear() {
            self.reloadDarkMode(self.darkMode)
        }
    }
    
    func reloadDarkMode(_ darkMode: Bool) {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
    
    func filteredSymbols(_ searchText: String) -> [String] {
        if searchText.isEmpty {
            return symbols
        }
        return symbols.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
