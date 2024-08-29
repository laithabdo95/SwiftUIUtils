//
//  SelectionViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI
import Combine

protocol ItemSelectable {
    func title() -> String
}

protocol SelectionConfigurable: ObservableObject {
    var options: [String] { get }
    
    var searchText: String { get set }
    var selectionType: SelectionViewModel.SelectionType { get }
    var selectedOptions: Set<String> { get }
    var filteredOptions: [String] { get }
    
    func toggleSelection(for option: String)
    
    init(options: [String], selectionType: SelectionViewModel.SelectionType)
}

class SelectionViewModel: SelectionConfigurable {
    internal let options: [String]
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
    
    required init(options: [String], selectionType: SelectionType = .single) {
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
