//
//  Destination.swift
//  Utilities
//
//  Created by Majd Aldawoud on 21/01/2025.
//

import SwiftUI

/// A type-erased wrapper for any destination conforming to `DestinationBuildable`.
///
/// `Destination` encapsulates both a unique identifier and a SwiftUI view representation,
/// allowing storage and comparison of heterogeneous destination types as a single, consistent type.
///
/// This struct is particularly useful for navigation scenarios, where you need to present
/// or store destinations of varying concrete types, but treat them uniformly.
///
/// - Properties:
///   - id: A unique, type-erased identifier representing the destination.
///   - view: The SwiftUI view associated with the destination, type-erased to `AnyView`.
///
/// - Initialization:
///   Use the initializer to wrap any conforming `DestinationBuildable` object. The wrapper
///   ensures both the identifier and view are type-erased for flexible storage.
///
/// - Comparison:
///   Two `Destination` values are considered equal if their `id` properties are equal.
///   The struct also conforms to `Hashable`, using the identifier for hashing.
///
/// - Usage:
///   Store an array of `Destination` for generalized navigation stacks, or use as keys in
///   collections that require hashing and comparison.
///
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
