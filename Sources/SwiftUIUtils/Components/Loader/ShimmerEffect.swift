//
//  ShimmerEffect.swift
//  SwiftUIUtils
//
//  Created by Mohammad Farhan on 09/07/2025.
//

import SwiftUI
import Combine

// MARK: - Shimmer Effect
public struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    let active: Bool
    
    public func body(content: Content) -> some View {
        content
            .redacted(reason: active ? .placeholder : [])
            .overlay(
                GeometryReader { proxy in
                    let gradient = LinearGradient(
                        colors: [.white.opacity(0.3), .white.opacity(0.7), .white.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    Rectangle()
                        .fill(gradient)
                        .rotationEffect(.degrees(30))
                        .offset(x: -proxy.size.width * 2 + phase * proxy.size.width * 3)
                }
                    .mask(content)
                    .allowsHitTesting(false)
            )
            .onAppear {
                guard active else { return }
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

public extension View {
    func shimmer(_ active: Bool) -> some View {
        modifier(ShimmerEffect(active: active))
    }
}

