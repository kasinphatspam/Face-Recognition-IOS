//
//  GrowingButton.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(self.color)
            .cornerRadius(6)
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
