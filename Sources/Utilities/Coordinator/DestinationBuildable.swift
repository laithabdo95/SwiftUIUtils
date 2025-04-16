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

public extension DestinationBuildable where Self: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool { true }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
