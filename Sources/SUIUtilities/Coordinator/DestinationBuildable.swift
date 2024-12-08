//
//  DestinationBuildable.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 11/11/2024.
//

import SwiftUI

protocol DestinationBuildable: Identifiable, Hashable {
    associatedtype ViewType: View
    var view: ViewType { get }
}

struct Destination: DestinationBuildable {
    let id: AnyHashable
    let view: AnyView
    
    init<T: DestinationBuildable>(_ destination: T) {
        self.id = destination.id
        self.view = AnyView(destination.view)
    }
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
