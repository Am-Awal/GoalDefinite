//
//  Styles.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct StrokeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var conrnerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: conrnerRadius, style: .continuous)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                            .black.opacity((colorScheme == .dark ? 0.3  : 0.1))
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .blendMode(.overlay)
        )
    }
}

extension View {
    func strokeStyle(conrnerRadius: CGFloat = 30) -> some View {
        modifier(StrokeModifier(conrnerRadius: conrnerRadius))
    }
}

