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
    
    public var errorMessage: String {
        switch self {
        case .required:
            "This Field is required"
        case .regex(let regex):
            regex.message
        }
    }
}
