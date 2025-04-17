//
//  SelectionViewModel.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI
import Combine

public protocol ItemSelectable {
    var title: String { get }
}

public protocol SelectionConfigurable: ObservableObject {
    var searchText: String { get set }
    var selectedOptions: Set<String> { get }
    var filteredOptions: [String] { get }
    
    func toggleSelection(for option: String)        
}

public class SelectionViewModel<Item: ItemSelectable>: SelectionConfigurable {
    var selectedItems: [Item] {
        items.filter { selectedOptions.contains($0.title) }
    }
    
    var items: [Item]
    
    private var options: [String] {
        items.map { $0.title }
    }
    
    @Published public var selectionType: SelectionType
    @Published public var searchText: String = ""
    @Published public var selectedOptions: Set<String> = []
    
    public var filteredOptions: [String] {
        if searchText.isEmpty {
            return options
        } else {
            return options.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    public func toggleSelection(for option: String) {
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
    
    public required init(items: [Item], selectionType: SelectionType = .single) {
        self.items = items
        self.selectionType = selectionType
    }
}

public extension SelectionViewModel {
    enum SelectionType {
        case single
        case multiple
    }
}
