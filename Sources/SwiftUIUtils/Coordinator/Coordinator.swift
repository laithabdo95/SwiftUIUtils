//
//  Coordinator.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 10/11/2024.
//

import SwiftUI

public final class Coordinator: CoordinatorBuildable {
    @Published public var path = NavigationPath()
    @Published public var sheet: Destination?
    @Published public var fullScreenCover: Destination?
    
    public var onSheetDismiss: OnDismissHandler?
    public var onFullScreenDismiss: OnDismissHandler?
    
    public init() {}
}

public extension Coordinator {
    typealias OnDismissHandler = (() -> Void)
}

public extension Coordinator {
    func push<D: DestinationBuildable>(page: D) {
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
    
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D) {
        self.fullScreenCover = Destination(fullScreenCover)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
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
