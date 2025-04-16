//
//  String+Extension.swift
//  Utilities
//
//  Created by Majd Aldawoud on 17/02/2025.
//

extension String {
    func formattedAsExpiryDate() -> String {
        let digits = self.filter { $0.isNumber }
        
        if digits.count > 4 {
            return String(digits.prefix(4))
        }
        
        if digits.count <= 2 {
            return digits
        }

        let firstTwo = String(digits.prefix(2))
        let remaining = String(digits.dropFirst(2))

        return firstTwo + "/" + remaining
    }
}
