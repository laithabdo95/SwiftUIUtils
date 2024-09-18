//
//  Regex.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Foundation

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
