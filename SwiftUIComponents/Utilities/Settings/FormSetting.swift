//
//  FormSetting.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

enum FormSetting {
    enum FormField {
        static var font: Font = .system(size: 16, weight: .regular)
        static var cornerRadius = 12.0
        static var borderColor: Color = .secondary
        static var backgroundColor: Color = .clear
        static var disabledColor: Color = .gray.opacity(0.2)
    }
    
    enum VerticalList {
        static var padding = 25.0
        static var cornerRadius = 12.0
        
        static var primaryButtonColor: Color = .primary
        static var buttonDisabledColor: Color = Color.gray.opacity(0.4)
        static var primaryButtonTitleColor: Color = .white
        
        static var secondaryButtonColor: Color = .secondary
        static var secondaryButtonTitleColor: Color = .white
    }
}
