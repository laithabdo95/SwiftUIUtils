//
//  TrackNavigationStack.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 04/08/2025.
//

import SwiftUI

/// A `ViewModifier` that tracks the presentation and dismissal of a view within a navigation stack.
///
/// `TrackNavigationStack` uses a unique identifier for each instance to notify a shared
/// `NavigationStackTracker` environment object when the view appears or disappears. This enables
/// tracking of stack navigation behaviors, such as pushing and popping views, and supports
/// additional actions when a view disappears (such as dismissing the view).
///
/// - Note: Requires a `NavigationStackTracker` to be provided as an environment object.
///
/// Usage:
/// ```swift
/// MyView().modifier(TrackNavigationStack())
/// // or, using the provided extension:
/// MyView().trackStack()
/// ```
///
struct TrackNavigationStack: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationStackTracker.self) private var tracker
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
