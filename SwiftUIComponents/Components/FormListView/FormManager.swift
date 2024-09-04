//
//  FormManager.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 04/09/2024.
//

import SwiftUI
import Combine

class FormManager: ObservableObject {
    @Published private(set) var validatableItems: [any FormListItemValidatable] = []

    var isValid: Bool {
        validatableItems.allSatisfy { $0.isValid == .valid }
    }

    func register(_ item: any FormListItemValidatable) {
        if !validatableItems.contains(where: { $0.id == item.id }) {
            validatableItems.append(item)
        }
    }

    func unregister(_ item: any FormListItemValidatable) {
        validatableItems.removeAll { $0.id == item.id }
    }
}
