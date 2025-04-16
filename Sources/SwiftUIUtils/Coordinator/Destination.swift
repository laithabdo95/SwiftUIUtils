//
//  Destination.swift
//  Utilities
//
//  Created by Majd Aldawoud on 21/01/2025.
//

import SwiftUI

public struct Destination: DestinationBuildable {
    public let id: AnyHashable
    public let view: AnyView
    
    public init<T: DestinationBuildable>(_ destination: T) {
        self.id = destination.id
        self.view = AnyView(destination.view)
    }
    
    public static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
