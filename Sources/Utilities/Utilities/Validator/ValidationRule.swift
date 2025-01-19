//
//  ValidationRule.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Foundation

public enum ValidationRule {
    
    case required
    case regex(Regex)
    case equal(String)
    case length(min: Int = 1, max: Int? = nil)
    
    public var errorMessage: String {
        switch self {
        case .required:
            return "This Field is required"
        case .regex(let regex):
            return regex.message
        case .equal:
            return "Does not match"
        case let .length(min, max):
            guard let max else { return "Minimum length is \(min)" }
            return "Minimum length is \(min), maximum length is \(max)"
        }
    }
}

// MARK: - Validate

public extension ValidationRule {
    func validate(text: String) -> ValidationResult {
        switch self {
        case .required:
            let isValid = required(text: text)
            return .init(
                isValid: isValid,
                errorMessage: errorMessage
            )
        case .regex(let regex):
            let isValid = self.regex(text: text, regex: regex)
            return .init(
                isValid: isValid,
                errorMessage: errorMessage
            )
        case .equal(let string):
            let isValid = equal(text: text, otherText: string)
            return .init(
                isValid: isValid,
                errorMessage: errorMessage
            )
        case let .length(min, max):
            let isValid = lenth(text: text, min: min, max: max)
            return .init(
                isValid: isValid,
                errorMessage: errorMessage
            )
        }
    }
}

// MARK: - ** Validation Functions **

/// - Required
private extension ValidationRule {
    func required(text: String) -> Bool {
        !text.isEmpty
    }
}

/// - Regex
private extension ValidationRule {
    func regex(
        text: String,
        regex: Regex
    ) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
        return predicate.evaluate(with: text)
    }
}

/// - Equal
private extension ValidationRule {
    func equal(
        text: String,
        otherText: String
    ) -> Bool {
        text == otherText
    }
}

/// - Length
private extension ValidationRule {
    func lenth(
        text: String,
        min: Int,
        max: Int?
    ) -> Bool {
        text.count >= min && text.count <= max ?? Int.max
    }
}
