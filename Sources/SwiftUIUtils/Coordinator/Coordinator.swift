//
//  Coordinator.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 10/11/2024.
//

import SwiftUI

public class Coordinator: CoordinatorBuildable {
    public typealias DestinationType = Destination

    @Published public var path = NavigationPath()
    @Published public var rootDestination: Destination?
    private var destinationStack: [Destination] = []

    @Published public var sheet: Destination?
    @Published public var customSheet: SheetDestination?
    @Published public var fullScreenCover: Destination?

    public var onSheetDismiss: OnDismissHandler?
    public var onFullScreenDismiss: OnDismissHandler?

    public var sheetOnDismiss: (() -> Void)?
    
    public init() {}
    
    public init(rootDestination: Destination) {
        self.rootDestination = rootDestination
    }
}

public extension Coordinator {
    typealias OnDismissHandler = (() -> Void)
}

public extension Coordinator {
    func push<D: DestinationBuildable>(page: D) {
        let destination = Destination(page)
        destinationStack.append(destination)
        path.append(destination)
    }

    func pop() {
        guard !destinationStack.isEmpty, !path.isEmpty else { return }
        destinationStack.removeLast()
        path.removeLast()
    }

    func popToRoot() {
        guard !destinationStack.isEmpty, !path.isEmpty else { return }
        destinationStack.removeAll()
        path = NavigationPath()
    }
    
    func popTo<D: DestinationBuildable>(_ destination: D) {
        let target = Destination(destination)
        guard let index = destinationStack.firstIndex(where: { $0 == target }) else {
            push(page: destination)
            return
        }

        let numberToRemove = destinationStack.count - index - 1
        guard numberToRemove > 0 else { return }

        for _ in 0..<numberToRemove {
            if !destinationStack.isEmpty { destinationStack.removeLast() }
            if !path.isEmpty { path.removeLast() }
        }
    }

    
    func presentSheet<D: DestinationBuildable>(_ sheet: D, size: SheetSize = .large) {
        self.sheet = Destination(sheet)
    }
    
    func presentCustomSheet<D>(_ sheet: D, size: SheetSize) where D : DestinationBuildable {
        self.customSheet = SheetDestination(destination: Destination(sheet), size: size)
    }
    
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D) {
        self.fullScreenCover = Destination(fullScreenCover)
    }
    
    func dismissSheet() {
        sheet = nil
        onSheetDismiss = nil
    }
    
    func dismissSheet(onDismiss: (() -> Void)? = nil) {
        self.sheet = nil
        dismissFullScreenCover()
        onSheetDismiss = nil
        if let onDismiss = onDismiss {
            onDismiss()
        } else {
            sheetOnDismiss?()
            sheetOnDismiss = nil
        }
    }
    
    func dismissFullScreenCover() {
        fullScreenCover = nil
    }
    
    /// Call this when presenting a sheet if you want to set a default onDismiss
    func setSheetOnDismiss(_ handler: (() -> Void)?) {
        sheetOnDismiss = handler
    }

    func setRoot<D: DestinationBuildable>(to destination: D, animated: Bool = false) {
        let newRoot = Destination(destination)
        
        // Update the root destination
        rootDestination = newRoot

        if animated {
            withAnimation(.easeInOut(duration: 0.3)) {
                forceMemoryCleanup()
            }
        } else {
            forceMemoryCleanup()
        }
    }
    
    func syncStackToMatchPath(count: Int) {
        while destinationStack.count > count {
            destinationStack.removeLast()
        }
    }
    
    /// Force memory cleanup by clearing all retained references
    func forceMemoryCleanup() {
        // Clear all retained references
        destinationStack.removeAll()
        path = NavigationPath()
        sheet = nil
        fullScreenCover = nil
        onSheetDismiss = nil
        onFullScreenDismiss = nil
        sheetOnDismiss = nil
    }
}
