//
//  FormPickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

class FormPickerViewModel: ObservableObject {
    let placeholder: String
    
    @Published var text: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published var isValid: Bool = true
    @Published var errorMessage: String = ""
    @Published var isDisabled: Bool = false
    @Published var isRequired: Bool
    
    private func validate() {
        isValid = isRequired ? !text.isEmpty : true
        errorMessage = isValid ? "" : ValidationRule.required.errorMessage
    }
    
    init(
        placeholder: String,
        isDisabled: Bool = false,
        isRequired: Bool = true
    ) {
        self.placeholder = placeholder
        self.isDisabled = isDisabled
        self.isRequired = isRequired
    }
}
