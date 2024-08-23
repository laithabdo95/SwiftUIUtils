//
//  TextValidator.swift
//  Example1
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

class TextValidator: ObservableObject {
    @Published var text: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published var isValid: Bool = true
    
    private let regexPattern: String = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    
    private func validate() {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        isValid = predicate.evaluate(with: text)
    }
}
