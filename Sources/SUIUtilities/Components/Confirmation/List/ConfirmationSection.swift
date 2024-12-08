//
//  ConfirmationSection.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 28/09/2024.
//

import Foundation

struct ConfirmationSection: Identifiable {
    var id = UUID()
    var title: String
    var items: [ConfirmationRowViewModel]
    
    init(
        title: String = "",
        items: [ConfirmationRowViewModel]
    ) {
        self.title = title
        self.items = items
    }
}
