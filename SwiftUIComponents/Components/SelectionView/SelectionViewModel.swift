//
//  SelectionViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI
import Combine

class SelectionViewModel: ObservableObject {
    private let options: [String]
    @Published var searchText: String = ""
    @Published var selectionType: SelectionType
    @Published var selectedOptions: Set<String> = []
    
    var filteredOptions: [String] {
        if searchText.isEmpty {
            return options
        } else {
            return options.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func toggleSelection(for option: String) {
        switch selectionType {
        case .single:
            selectedOptions = [option]
        case .multiple:
            if selectedOptions.contains(option) {
                selectedOptions.remove(option)
            } else {
                selectedOptions.insert(option)
            }
        }
    }
    
    init(options: [String], selectionType: SelectionType = .single) {
        self.options = options
        self.selectionType = selectionType
    }
}

extension SelectionViewModel {
    enum SelectionType {
        case single
        case multiple
    }
}
