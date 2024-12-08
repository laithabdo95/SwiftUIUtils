//
//  FormFieldViewModel.swift
//  Example1
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

protocol FormFieldConfigurable: ObservableObject, FormListItemValidatable {
    var id: UUID { get }
    var placeholder: String { get }
    var rules: [ValidationRule] { get }
    var text: String { get set }
    var errorMessage: String { get }
    var isDisabled: Bool  { get }
    var isEditingDisabled: Bool { get }
    var fieldType: FormFieldViewModel.FieldType { get }
    var keyboardType: UIKeyboardType { get }
    
    func validate()
    func getValidationResult() -> [FormFieldViewModel.ValidationResult]
}

class FormFieldViewModel: FormFieldConfigurable {
    @FieldPlaceHolder var placeholder: String = ""
    let rules: [ValidationRule]
    let fieldType: FieldType
    var id: UUID = UUID()
    var keyboardType: UIKeyboardType
    
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
        fieldType: FieldType = .field,
        keyboardType: UIKeyboardType = .default
    ) {
        self.placeholder = placeHolder
        self.isDisabled = isDisabled
        self.isEditingDisabled = isEditingDisabled
        self.rules = rules
        self.fieldType = fieldType
        self.keyboardType = keyboardType
        self.$placeholder.update(rules.isEmpty)
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
        case datePicker
        
        var imageName: String? {
            switch self {
            case .picker: return "chevron.down"
            case .datePicker: return "calendar"
            default: return nil
            }
        }
        
        var isPicker: Bool {
            switch self {
            case .picker, .datePicker: return true
            default: return false
            }
        }
    }
}

@propertyWrapper
class FieldPlaceHolder {
    private var value: String = ""
    var isOptional: Bool
    
    var wrappedValue: String {
        get { value }
        set {
            if !newValue.isEmpty {
                value = isOptional ? String(format: "%@ %@", newValue, "(Optional)") : newValue
            }
        }
    }
    
    var projectedValue: FieldPlaceHolder {
        return self
    }
    
    init(wrappedValue: String, isOptional: Bool = false) {
        self.isOptional = isOptional
        self.wrappedValue = wrappedValue
    }
    
    func update(_ isOptional: Bool) {
        self.isOptional = isOptional
        self.wrappedValue = value
    }
}
