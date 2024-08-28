//
//  FormFieldViewModel.swift
//  Example1
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

class FormFieldViewModel: ObservableObject {
    let placeholder: String
    let rules: [ValidationRule]
    
    @Published var text: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published var isValid: Bool = true
    @Published var errorMessage: String = ""
    @Published var isDisabled: Bool = false
    
    private func validate() {
       let result = getValidationResult()
        isValid = result.filter { !$0.isValid }.isEmpty
        errorMessage = result.first(where: { !$0.isValid })?.errorMessage ?? ""
    }
    
    private func getValidationResult() -> [ValidationResult] {
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
    
    init(placeHolder: String, isDisabled: Bool = false, rules: [ValidationRule]) {
        self.placeholder = placeHolder
        self.isDisabled = isDisabled
        self.rules = rules
    }
}

extension FormFieldViewModel {
    struct ValidationResult {
        let isValid: Bool
        let errorMessage: String
    }
}

enum ValidationRule {
    case required
    case regex(Regex)
    
    var errorMessage: String {
        switch self {
        case .required:
            "This Field is required"
        case .regex(let regex):
            regex.message
        }
    }
}

class Regex {
    let rawValue: String
    let message: String
    
    init(rawValue: String, message: String) {
        self.rawValue = rawValue
        self.message = message
    }
    
    static var email: Regex {
        Regex(rawValue: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$", message: "Invalid, Should be valid email")
    }
    
    static var englishLettersAndNumber: Regex {
        Regex(rawValue: "^([a-zA-Z0-9]{0,100})$", message: "Invalid, you should using english letters and numbers")
    }
}
