//
//  Coordinator.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 10/11/2024.
//

import SwiftUI

/// `Coordinator` is a navigation management class designed for SwiftUI applications.
/// 
/// It acts as a central authority for managing navigation paths,
/// presenting destinations, sheets, and full screen covers, as well as handling dismissal callbacks.
/// 
/// - Important: This class is annotated with `@MainActor` and must be used from the main queue.
/// 
/// ## Features
/// - Push and pop navigation destinations
/// - Present and dismiss sheets and full screen covers
/// - Dismiss the top entry or all entries, with optional handlers
/// - View construction helpers for destinations, sheets, and full screen covers
/// 
/// ## Properties
/// - `path`: The current navigation path.
/// - `destinations`: The stack of pushed destinations.
/// - `sheet`: The currently presented sheet destination.
/// - `fullScreenCover`: The currently presented full screen cover destination.
/// - `onEntryDismissed`: Handler called when the topmost entry is dismissed.
/// - `onEntriesDismissed`: Handler called when all entries are dismissed.
/// 
/// ## Usage
/// Use `push(_:)` to navigate forward, `pop()` or `popToRoot()` to go back,
/// `presentSheet(_:)` or `presentFullScreenCover(_:)` for modal presentations,
/// and the `dismiss...` methods for dismissals.
/// 
/// The `build(page:)`, `buildSheet(sheet:)`, and `buildFullScreenCover(cover:)`
/// helpers construct the appropriate views for UI presentation.
/// 
/// ## Conformance
/// - Conforms to `CoordinatorBuildable` protocol.
/// - Must interact with `Destination` and `DestinationBuildable` for navigation logic.
/// 
@MainActor
@Observable
public final class Coordinator: CoordinatorBuildable {
    public var path = NavigationPath()
    public var destinations: [Destination] = []
    public var sheet: Destination?
    public var fullScreenCover: Destination?
    
    @ObservationIgnored public var onEntryDismissed: OnDismissHandler?
    @ObservationIgnored public var onEntriesDismissed: OnDismissHandler?
    
    public init() {}
}

public extension Coordinator {
    typealias OnDismissHandler = (() -> Void)
}

public extension Coordinator {
    func push<D: DestinationBuildable>(_ page: D) {
        path.append(Destination(page))
        destinations.append(Destination(page))
    }
    
    func pop() {
        path.removeLast()
        destinations.removeLast()
    }
    
    func popDestination() {
        guard destinations.isNotEmpty else { return }
        destinations.removeLast()
    }
    
    func popTo<D>(_ destination: D) where D : DestinationBuildable {
        guard let index = destinations.lastIndex(where: { $0.id == Destination(destination).id }) else { popToRoot(); return }
        
        let countToRemove = destinations.count - index - 1
        guard countToRemove > 0 else { return }
        
        destinations.removeLast(countToRemove)
        path.removeLast(countToRemove)
    }
    
    func popToRoot() {
        sheet = nil
        fullScreenCover = nil
        path.removeLast(path.count)
        destinations.removeAll()
    }
    
    func presentSheet<D: DestinationBuildable>(_ sheet: D) {
        self.sheet = Destination(sheet)
    }
    
    func presentSheet<D>(entryPoint: D) where D : DestinationBuildable {
        self.sheet = Destination(EntryPointFactoryView(root: entryPoint))
    }
    
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D) {
        self.fullScreenCover = Destination(fullScreenCover)
    }
    
    func presentFullScreenCover<D>(entryPoint: D) where D : DestinationBuildable {
        self.fullScreenCover = Destination(EntryPointFactoryView(root: entryPoint))
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
        
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func dismissEntry() {
        onEntryDismissed?()
    }
    
    func dismissEntries() {
        onEntriesDismissed?()
    }
}

public extension Coordinator {
    @ViewBuilder
    func build(page: Destination) -> some View {
        page.view
    }

    @ViewBuilder
    func buildSheet(sheet: Destination) -> some View {
        sheet.view
    }

    @ViewBuilder
    func buildFullScreenCover(cover: Destination) -> some View {
        cover.view
    }
}
