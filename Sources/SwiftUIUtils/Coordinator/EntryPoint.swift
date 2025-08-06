//
//  EntryPoint.swift
//  CoordinatorApplication
//
//  Created by Laith Abdo on 04/08/2025.
//

import SwiftUI

/// A SwiftUI view that serves as the entry point for a navigation stack, coordinating navigation, sheet, and full screen cover presentation.
/// 
/// `EntryPointFactoryView` wraps a root destination conforming to `DestinationBuildable`, sets up a `Coordinator` to manage navigation state,
/// and integrates with a global `NavigationStackTracker`. It provides navigation via `NavigationStack`, as well as presentation of sheets and
/// full screen covers using a type-erased destination system.
///
/// The view automatically handles dismissals through the environment, and exposes identity and hashability for use in navigation collections.
///
/// - Parameters:
///   - Content: The root destination type conforming to `DestinationBuildable`.
///
/// Usage:
/// ```swift
/// EntryPointFactoryView(root: MyDestination(...))
/// ```
///
/// - Note: This view is usually used to bootstrap a navigation architecture with custom destination and coordinator logic.
///
/// - Requires: `Content` must conform to `DestinationBuildable` and provide a stable `id` property.
///
/// - Environment:
///   - `dismiss`: Used to programmatically dismiss the entry stack.
///   - `tracker`: An environment object tracking all navigation stacks.
///
/// - EnvironmentObjects:
///   - `Coordinator`: Injected for use by descendant views in the navigation stack.
///
/// - SeeAlso: `DestinationBuildable`, `Coordinator`, `NavigationStackTracker`
/// 
public struct EntryPointFactoryView<Content: DestinationBuildable>: View, @preconcurrency DestinationBuildable {
    
    @StateObject private var coordinator: Coordinator = .init()
    private let root: Content
    public let id: AnyHashable
    @EnvironmentObject var tracker: NavigationStackTracker
    
    public init(root: Content) {
        self.root = root
        self.id = AnyHashable(root.id)
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: Destination(root))
                .navigationDestination(for: Destination.self) { destination in
                    coordinator.build(page: destination)
                }
                .sheet(item: $coordinator.sheet) { destination in
                                    coordinator.buildSheet(sheet: destination)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { destination in
                    coordinator.buildFullScreenCover(cover: destination)
                        .background(Color.white)
                }
        }
        .onAppear {
            coordinator.onEntryDismissed = {
                tracker.dismiss()
            }
            coordinator.onEntriesDismissed = {
                tracker.dismissAllStacks()
            }
        }
        .environmentObject(coordinator)
        .trackStack()
    }
    
    public var view: some View { self }
    
    public static func == (lhs: EntryPointFactoryView<Content>, rhs: EntryPointFactoryView<Content>) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
