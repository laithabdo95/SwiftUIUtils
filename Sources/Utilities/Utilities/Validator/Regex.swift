//
//  Regex.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Foundation

public class Regex {
    let rawValue: String
    let message: String
    
    public init(rawValue: String, message: String) {
        self.rawValue = rawValue
        self.message = message
    }
    
    public static var email: Regex {
        Regex(rawValue: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$", message: "Invalid, Should be valid email")
    }
    
    public static var englishLettersAndNumber: Regex {
        Regex(rawValue: "^([a-zA-Z0-9]{0,100})$", message: "Invalid, you should using english letters and numbers")
    }
    
    public static var expiryDate: Regex {
        Regex(rawValue: "^(0[1-9]|1[0-2])/\\d{2}$", message: "Invalid, expiry date should be MM/YY")
    }
}
