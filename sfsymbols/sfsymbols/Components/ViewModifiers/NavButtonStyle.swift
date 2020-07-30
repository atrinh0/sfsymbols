//
//  NavButtonStyle.swift
//  sfsymbols
//
//  Created by An Trinh on 30/7/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct NavButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.title2.bold())
            .imageScale(.large)
            .foregroundColor(Color.primary.opacity(0.7))
    }
}

extension Image {
    func navButtonStyle() -> some View {
        self.modifier(NavButton())
    }
}
