//
//  TrackNavigationStack.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 04/08/2025.
//

import SwiftUI

struct TrackNavigationStack: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tracker: NavigationStackTracker
    private let id = UUID()
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                tracker.didAppear(id: id) {
                    dismiss()
                }
            }
            .onDisappear {
                tracker.didDisappear(id: id)
            }
    }
}

extension View {
    func trackStack() -> some View {
        modifier(TrackNavigationStack())
    }
}
