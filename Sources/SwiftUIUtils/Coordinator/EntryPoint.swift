//
//  EntryPoint.swift
//  CoordinatorApplication
//
//  Created by Laith Abdo on 04/08/2025.
//

import SwiftUI

public struct EntryPointFactoryView<Content: DestinationBuildable>: View, @preconcurrency DestinationBuildable {
    
    @StateObject private var coordinator: Coordinator = .init()
    private let root: Content
    public let id: AnyHashable
    
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
        .environmentObject(coordinator)
    }
    
    public var view: some View { self }
    
    public static func == (lhs: EntryPointFactoryView<Content>, rhs: EntryPointFactoryView<Content>) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
