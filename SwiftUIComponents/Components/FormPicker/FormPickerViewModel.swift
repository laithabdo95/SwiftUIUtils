//
//  FormPickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Combine
import SwiftUI

class FormPickerViewModel: FormFieldViewModel {
    
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
        self.isRequired = isRequired
        self.selectionViewModel = selectionViewModel
        super.init(
            placeHolder: placeholder,
            isDisabled: isDisabled,
            rules: isRequired ? [.required] : []
        )
        bindSelectionViewModel()
    }
    
    private func bindSelectionViewModel() {
        selectionViewModel.$selectedOptions
            .map { $0.joined(separator: ", ")}
            .sink { [weak self] text in
                guard let self else { return }
                self.text = text
            }
            .store(in: &cancellables)
    }
}
