//
//  FormFieldViewModel.swift
//  Example1
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

protocol FormFieldConfigurable: ObservableObject {
    var placeholder: String { get }
    var rules: [ValidationRule] { get }
    var text: String { get set }
    var isValid: FormFieldViewModel.FieldStatus { get }
    var errorMessage: String { get }
    var isDisabled: Bool  { get }
    var isEditingDisabled: Bool { get }
    var fieldType: FormFieldViewModel.FieldType { get }
    
    func validate()
    func getValidationResult() -> [FormFieldViewModel.ValidationResult]
}

class FormFieldViewModel: FormFieldConfigurable {
    let placeholder: String
    let rules: [ValidationRule]
    let fieldType: FieldType
    
    @Published var text: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published var isValid: FieldStatus = .notSet
    @Published var errorMessage: String = ""
    @Published var isDisabled: Bool = false
    @Published var isEditingDisabled: Bool = false
    
    internal func validate() {
       let result = getValidationResult()
        isValid = result.filter { !$0.isValid }.isEmpty ? .valid : .notValid
        errorMessage = result.first(where: { !$0.isValid })?.errorMessage ?? ""
    }
    
    internal func getValidationResult() -> [ValidationResult] {
        var result: [ValidationResult] = []
        rules.forEach { rule in
            errorMessage = rule.errorMessage
            switch rule {
            case .required:
                result.append(ValidationResult(isValid: !text.isEmpty, errorMessage: rule.errorMessage))
            case .regex(let regex):
                let predicate = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
                let isValid = predicate.evaluate(with: text)
                result.append(ValidationResult(isValid: isValid, errorMessage: rule.errorMessage))
            }
        }
        return result
    }
    
    init(
        placeHolder: String,
        isDisabled: Bool = false,
        isEditingDisabled: Bool = false,
        rules: [ValidationRule],
        fieldType: FieldType = .field
    ) {
        self.placeholder = placeHolder
        self.isDisabled = isDisabled
        self.isEditingDisabled = isEditingDisabled
        self.rules = rules
        self.fieldType = fieldType
    }
}

extension FormFieldViewModel {
    struct ValidationResult {
        let isValid: Bool
        let errorMessage: String
    }
    
    enum FieldStatus {
        case notSet
        case valid
        case notValid
    }
    
    enum FieldType {
        case field
        case picker
        case secured
    }
}

