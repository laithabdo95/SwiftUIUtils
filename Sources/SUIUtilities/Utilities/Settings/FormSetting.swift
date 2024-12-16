//
//  FormSetting.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

public enum ColorStyle {
    case normal(Color)
    case gradient(Gradient, startPoint: UnitPoint, endPoint: UnitPoint)
}

public enum FormSetting {
    @MainActor
    public enum FormField {
        public static var font: Font = .system(size: 16, weight: .regular)
        public static var cornerRadius = 12.0
        public static var borderColor: Color = .secondary
        public static var backgroundColor: Color = .clear
        public static var disabledColor: Color = .gray.opacity(0.2)
        public static var headerTitleColor: Color = .secondary
    }
    
    @MainActor
    public enum VerticalList {
        public static var padding = 25.0
        public static var cornerRadius = 12.0
        public static var buttonDisabledColor: Color = Color.gray.opacity(0.4)
        public static var primaryButtonColor: ColorStyle = .normal(.primary)
        public static var primaryButtonTitleColor: Color = .white
        public static var secondaryButtonTitleColor: Color = .white
        public static var secondaryButtonColor: ColorStyle = .normal(.secondary)
    }
}
