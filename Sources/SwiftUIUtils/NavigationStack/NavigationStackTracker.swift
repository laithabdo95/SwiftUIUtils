//
//  NavigationStackTracker.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 04/08/2025.
//

import SwiftUI

/// A class that tracks the number of active navigation stacks and provides a centralized
/// way to manage their dismissal in SwiftUI-based navigation flows.
///
/// `NavigationStackTracker` is intended to be used as an `ObservableObject`
/// to coordinate navigation stack appearance, disappearance, and mass dismissal
/// (such as when resetting navigation state from the root).
///
/// - Tracks the number of active navigation stacks via the `activeStacks` published property.
/// - Stores dismiss actions for each stack, allowing for programmatic dismissal of all stacks.
/// - Designed to integrate with SwiftUI navigation views by passing unique identifiers and dismiss closures.
///
/// ## Usage
///
/// Instantiate and inject an instance of `NavigationStackTracker` into your environment or as needed,
/// then call `didAppear(id:dismiss:)` when a navigation stack becomes active, and `didDisappear(id:)` when it is removed.
/// Call `dismissAllStacks()` to dismiss all tracked navigation stacks.
///
/// ## Example
/// ```swift
/// let tracker = NavigationStackTracker()
/// tracker.didAppear(id: myID, dismiss: { /* dismiss logic */ })
/// // ...
/// tracker.dismissAllStacks()
/// ```
/// 
@Observable
@MainActor
public class NavigationStackTracker {
    var activeStacks: Int = 0
    private var dismissActions: [UUID: () -> Void] = [:]
    private var stackOrder: [UUID] = []
    
    func didAppear(id: UUID, dismiss: @escaping () -> Void) {
        Task { @MainActor in
            activeStacks += 1
            dismissActions[id] = dismiss
            stackOrder.append(id)
        }
    }
    
    func didDisappear(id: UUID) {
        Task { @MainActor in
            activeStacks = max(activeStacks - 1, 0)
            dismissActions.removeValue(forKey: id)
            if let idx = stackOrder.firstIndex(of: id) {
                stackOrder.remove(at: idx)
            }
        }
    }
    
    /// Programmatically dismisses a all navigation stacks by its identifier.
    func dismissAllStacks() {
        Task { @MainActor in
            self.dismissActions.values.forEach { $0() }
            self.dismissActions.removeAll()
            self.stackOrder.removeAll()
            self.activeStacks = 0
        }
    }
    
    /// Programmatically dismisses the most recently presented navigation stack.
    func dismiss() {
        Task { @MainActor in
            guard let last = stackOrder.last, let dismiss = dismissActions[last] else { return }
            dismiss()
            dismissActions.removeValue(forKey: last)
            stackOrder.removeLast()
            activeStacks = max(activeStacks - 1, 0)
        }
    }
    
    public init() {}
}
