//
//  FormSetting.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

@MainActor
public enum ColorStyle {
    case normal(Color)
    case gradient(Gradient, startPoint: UnitPoint, endPoint: UnitPoint)
}

@MainActor
public struct FormSetting {
    
    @MainActor public var formField = FormField()
    @MainActor public var verticalList = VerticalList()
    @MainActor public var primaryButton = PrimaryButton()
    
    @MainActor
    public struct FormField {
        public var font: Font = .system(size: 16, weight: .regular)
        public var cornerRadius = 12.0
        public var borderColor: Color = .secondary
        public var backgroundColor: Color = .clear
        public var disabledColor: Color = .gray.opacity(0.2)
        public var headerTitleColor: Color = .secondary
        public var titleColor: Color = .blue
        public var titleFont: Font = .headline
        public var titleFontWeight: Font.Weight = .regular
    }
    
    @MainActor
    public struct VerticalList {
        public var padding = 25.0
        public var cornerRadius = 12.0
        public var buttonDisabledColor: Color = Color.gray.opacity(0.4)
        public var primaryButtonColor: ColorStyle = .normal(.primary)
        public var primaryButtonTitleColor: Color = .white
        public var secondaryButtonTitleColor: Color = .white
        public var secondaryButtonColor: ColorStyle = .normal(.secondary)
    }
    
    @MainActor
    public struct PrimaryButton {
        public var font: Font = .system(size: 16, weight: .regular)
        public var titleColor: Color = .white
        public var titleFont: Font = .system(size: 16, weight: .regular)
        public var cornerRadius = 25.0
        public var borderColor: Color = .secondary
        public var backgroundColor: ColorStyle = .normal(.blue)
        public var disabledColor: Color = .gray.opacity(0.2)
        public var padding: EdgeInsets = .init(top: .zero, leading: 30, bottom: .zero, trailing: 30)
    }
}

public extension FormSetting {
    @MainActor static var `default` = Self()
}
