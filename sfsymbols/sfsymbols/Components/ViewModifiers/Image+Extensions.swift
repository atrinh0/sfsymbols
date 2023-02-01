//
//  Image+Extensions.swift
//  sfsymbols
//
//  Created by An Trinh on 28/11/2021.
//  Copyright © 2021 An Trinh. All rights reserved.
//

import SwiftUI

struct NavButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.bold())
            .imageScale(.large)
            .foregroundColor(.primary.opacity(0.7))
    }
}

extension Image {
    func navButtonStyle() -> some View {
        modifier(NavButton())
    }
}
