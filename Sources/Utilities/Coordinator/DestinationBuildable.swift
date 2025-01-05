//
//  DestinationBuildable.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 11/11/2024.
//

import SwiftUI

public protocol DestinationBuildable: Identifiable, Hashable {
    associatedtype ViewType: View
    var view: ViewType { get }
}

public struct Destination: DestinationBuildable {
    public let id: AnyHashable
    public let view: AnyView
    
    public init<T: DestinationBuildable>(_ destination: T) {
        self.id = destination.id
        self.view = AnyView(destination.view)
    }
    
    public static func == (lhs: Destination, rhs: Destination) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
