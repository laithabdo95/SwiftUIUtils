//
//  DestinationBuildable.swift
//  SwiftUIUtils
//
//  Created by Majd Aldawoud on 11/11/2024.
//

import SwiftUI

/// A protocol that represents a type capable of producing a SwiftUI `View` as a navigation destination.
///
/// Conforming types must be both `Identifiable` and `Hashable`, ensuring uniqueness and value semantics.
/// The protocol requires specifying the associated `ViewType` (a SwiftUI `View`), and a property to retrieve it.
///
/// This protocol is typically used to model navigation destinations in navigation-driven SwiftUI
/// apps, providing type-safe view construction and identity handling.
///
/// - Requirements:
///   - `ViewType`: The type of view to be produced, conforming to `View`.
///   - `view`: An instance of the destination `ViewType`.
public protocol DestinationBuildable: Identifiable, Hashable {
    associatedtype ViewType: View
    var view: ViewType { get }
}

public extension DestinationBuildable where Self: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
