//
//  ConfirmationSection.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 28/09/2024.
//

import Foundation

public struct ConfirmationSection: Identifiable {
    public var id = UUID()
    public var title: String
    public var items: [ConfirmationRowViewModel]
    
    public init(
        title: String = "",
        items: [ConfirmationRowViewModel]
    ) {
        self.title = title
        self.items = items
    }
}
