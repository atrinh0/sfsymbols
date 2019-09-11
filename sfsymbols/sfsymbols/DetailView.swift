//
//  DetailView.swift
//  sfsymbols
//
//  Created by An Trinh on 10/9/19.
//  Copyright © 2019 An Trinh. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let symbol: String
    
    let fontWeights = [Font.Weight.ultraLight,
                       Font.Weight.thin,
                       Font.Weight.light,
                       Font.Weight.regular,
                       Font.Weight.medium,
                       Font.Weight.semibold,
                       Font.Weight.bold,
                       Font.Weight.heavy,
                       Font.Weight.black]
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image(systemName: symbol)
                                .font(.system(size: 250))
                                .frame(height: 350)
                        }
                        Spacer()
                    }
                    Section(header: Text("Weights")) {
                        ForEach(fontWeights, id:\.self) { weight in
                            HStack {
                                Image(systemName: self.symbol)
                                    .font(.system(size: 25, weight: weight))
                                    .frame(width: 40, height: 40)
                                Text(self.weightDescription(weight: weight))
                                    .font(.system(size: 18, weight: weight))
                            }
                        }
                    }
                }
                .navigationBarTitle(symbol)
                .navigationBarItems(leading: Button(action: { }) {
                    Image(systemName: symbol)
                        .imageScale(.large)
                        .padding()
                    }, trailing: Button(action: { }) {
                        Image(systemName: symbol)
                            .imageScale(.large)
                            .padding()
                })
            }
            .tabItem {
                VStack {
                    Image(systemName: symbol)
                        .imageScale(.large)
                    Text(symbol)
                }
            }
        }
    }
    
    func weightDescription(weight: Font.Weight) -> String {
        switch weight {
        case .ultraLight:
            return "ultralight"
        case .thin:
            return "thin"
        case .light:
            return "light"
        case .regular:
            return "regular"
        case .medium:
            return "medium"
        case .semibold:
            return "semibold"
        case .bold:
            return "bold"
        case .heavy:
            return "heavy"
        case .black:
            return "black"
        default:
            return ""
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(symbol: "paperplane")
    }
}
