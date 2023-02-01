//
//  Button+Extensions.swift
//  sfsymbols
//
//  Created by An Trinh on 30/7/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct ButtonPressedStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .opacity(configuration.isPressed ? 0.75 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1),
                       value: configuration.isPressed)
    }
}

extension Button {
    func pressableButton() -> some View {
        buttonStyle(ButtonPressedStyle())
    }
}
