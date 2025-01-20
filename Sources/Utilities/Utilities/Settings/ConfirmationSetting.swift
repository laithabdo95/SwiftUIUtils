//
//  ConfirmationSetting.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 27/10/2024.
//

import SwiftUI

@MainActor
public struct ConfirmationSetting {
    
    @MainActor public var header = SectionHeader()
    @MainActor public var list = ListView()
    @MainActor public var row = RowView()
    
    @MainActor
    public struct SectionHeader {
        public var foregroundColor: Color = .gray
    }
    
    @MainActor
    public struct ListView {
        public var backgroundColor: Color = .white
        public var rowsBackgroundColor: Color = Color(.lightGray).opacity(0.4)
        public var lineSeperator: Visibility = .hidden
        public var actionButtonTitle: String = "Confirm"
        public var actionButtonColor: Color = .black
        public var actionButtonTitleColor: Color = .white
        public var actionButtonCornerRadius: CGFloat = 10
    }
    
    @MainActor
    public struct RowView {
        public var keyTextFont: Font = .headline
        public var keyTextForgroundColor: Color = .black
        public var valueTextFont: Font = .subheadline
        public var valueTextForgroundColor: Color = .gray
    }
}

public extension ConfirmationSetting {
    @MainActor static var `default` = Self()
}
