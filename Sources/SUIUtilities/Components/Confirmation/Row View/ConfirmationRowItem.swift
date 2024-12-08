//
//  ConfirmationItem.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 22/09/2024.
//

import Foundation
import UIKit

struct ConfirmationRowItem: Identifiable {
    var id = UUID()
    var key: String
    var value: String
    
    init(
        id: UUID = UUID(),
        key: String,
        value: String
    ) {
        self.id = id
        self.key = key
        self.value = value
    }
}
