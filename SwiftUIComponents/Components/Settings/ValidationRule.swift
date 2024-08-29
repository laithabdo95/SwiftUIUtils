//
//  ValidationRule.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Foundation

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
