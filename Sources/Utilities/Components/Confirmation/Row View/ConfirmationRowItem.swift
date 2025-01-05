//
//  ConfirmationItem.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 22/09/2024.
//

import Foundation
import UIKit

public struct ConfirmationRowItem: Identifiable {
    public var id = UUID()
    public var key: String
    public var value: String
    
    public init(
        id: UUID = UUID(),
        key: String,
        value: String
    ) {
        self.id = id
        self.key = key
        self.value = value
    }
}
