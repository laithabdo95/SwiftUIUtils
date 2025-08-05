//
//  Coordinator.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 10/11/2024.
//

import SwiftUI

@MainActor
public final class Coordinator: @MainActor CoordinatorBuildable {
    @Published public var path = NavigationPath()
    @Published public var sheet: Destination?
    @Published public var fullScreenCover: Destination?
    
    public var onEntryDismissed: OnDismissHandler?
    public var onEntriesDismissed: OnDismissHandler?
    
    public init() {}
}

public extension Coordinator {
    typealias OnDismissHandler = (() -> Void)
}

public extension Coordinator {
    func push<D: DestinationBuildable>(_ page: D) {
        path.append(Destination(page))
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        sheet = nil
        fullScreenCover = nil
        path.removeLast(path.count)
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
