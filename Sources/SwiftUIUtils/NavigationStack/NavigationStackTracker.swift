//
//  NavigationStackTracker.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 04/08/2025.
//

import SwiftUI

public class NavigationStackTracker: ObservableObject {
    @Published var activeStacks: Int = 0
    private var dismissActions: [UUID: () -> Void] = [:]
    
    func didAppear(id: UUID, dismiss: @escaping () -> Void) {
        activeStacks += 1
        dismissActions[id] = dismiss
    }
    
    func didDisappear(id: UUID) {
        activeStacks = max(activeStacks - 1, 0)
        dismissActions.removeValue(forKey: id)
    }
    
    func dismissAllStacks() {
        dismissActions.values.forEach { $0() }
        dismissActions.removeAll()
        activeStacks = 0
    }
    
    public init() {}
}
