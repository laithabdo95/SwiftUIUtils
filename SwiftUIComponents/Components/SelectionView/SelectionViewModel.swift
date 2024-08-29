//
//  SelectionViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI
import Combine

protocol ItemSelectable {
    var title: String { get }
}

protocol SelectionConfigurable: ObservableObject {    
    var selectionType: SelectionViewModel.SelectionType { get }
    var selectedItems: [ItemSelectable] { get }
    var searchText: String { get set }
    var selectedOptions: Set<String> { get }
    var filteredOptions: [String] { get }
    
    func toggleSelection(for option: String)
        
    init(items: [ItemSelectable], selectionType: SelectionViewModel.SelectionType)
}

class SelectionViewModel: SelectionConfigurable {
    var selectedItems: [ItemSelectable] {
        items.filter { options.contains($0.title) }
    }
    
    var items: [ItemSelectable]
    
    private var options: [String] {
        items.map { $0.title }
    }
    
    @Published var selectionType: SelectionType
    @Published internal var searchText: String = ""
    @Published internal var selectedOptions: Set<String> = []
    
    internal var filteredOptions: [String] {
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
    
    required init(items: [ItemSelectable], selectionType: SelectionType = .single) {
        self.items = items
        self.selectionType = selectionType
    }
}

extension SelectionViewModel {
    enum SelectionType {
        case single
        case multiple
    }
}
