//
//  ConfirmationListViewModel.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 22/09/2024.
//

import SwiftUI

protocol ConfirmationListViewConfigurable: ObservableObject {
    var sections: [ConfirmationSection] { get }
}

final class ConfirmationListViewModel: ConfirmationListViewConfigurable {
    
    // MARK: Properties
    
    var sections: [ConfirmationSection]
    
    // MARK: Init
    
    /// Initializes the view model with multiple sections.
    /// - Parameter sections: An array of **`(ConfirmationSection)`** objects that will be managed by the view model.
    
    init(_ sections: [ConfirmationSection]) {
        self.sections = sections
    }

    /// Initializes the view model with a single section.
    /// - Parameter Section: A **`(ConfirmationSection)`** object that will be managed by the view model.
    
    init(_ section: ConfirmationSection) {
        self.sections = [section]
    }
}
