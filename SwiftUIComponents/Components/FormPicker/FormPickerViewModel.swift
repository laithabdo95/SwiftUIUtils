//
//  FormPickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Combine
import SwiftUI

class FormPickerViewModel: ObservableObject {
    let placeholder: String
    
    @Published var text: String = ""
    
    @Published var isValid: Bool = true
    @Published var errorMessage: String = ""
    @Published var isDisabled: Bool = false
    @Published var isRequired: Bool
    var selectionViewModel: SelectionViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    private func validate() {
        isValid = isRequired ? !text.isEmpty : true
        errorMessage = isValid ? "" : ValidationRule.required.errorMessage
    }
    
    init(
        placeholder: String,
        isDisabled: Bool = false,
        isRequired: Bool = true,
        selectionViewModel: SelectionViewModel
    ) {
        self.placeholder = placeholder
        self.isDisabled = isDisabled
        self.isRequired = isRequired
        self.selectionViewModel = selectionViewModel
        bindSelectionViewModel()
    }
    
    private func bindSelectionViewModel() {
        selectionViewModel.$selectedOptions
            .map { $0.joined(separator: ", ")}
            .sink { [weak self] text in
                guard let self else { return }
                self.text = text
                validate() // Explicitly call validate after updating text
            }
            .store(in: &cancellables)
    }
}
