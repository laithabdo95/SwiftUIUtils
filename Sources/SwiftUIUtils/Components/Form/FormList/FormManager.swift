//
//  FormManager.swift
//  SwiftUIUtils
//
//  Created by Majd Aldawood on 04/09/2024.
//

import SwiftUI
import Observation

@Observable
public class FormManager {
    private(set) var validatableItems: [any FormListItemValidatable] = []

    public init() { }
    
    public var isValid: Bool {
        validatableItems.allSatisfy { $0.isValid == .valid }
    }

    public func register(_ item: any FormListItemValidatable) {
        if !validatableItems.contains(where: { $0.id == item.id }) {
            validatableItems.append(item)
        }
    }

    public func unregister(_ item: any FormListItemValidatable) {
        validatableItems.removeAll { $0.id == item.id }
    }
}
