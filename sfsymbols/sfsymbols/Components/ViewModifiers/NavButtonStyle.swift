//
//  NavButtonStyle.swift
//  sfsymbols
//
//  Created by An Trinh on 30/7/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

// MARK: - Image

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

// MARK: - Button

struct ButtonPressedStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.default)
    }
}

extension Button {
    func pressableButton() -> some View {
        self.buttonStyle(ButtonPressedStyle())
    }
}
