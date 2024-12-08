//
//  ConfirmationSetting.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 27/10/2024.
//

import SwiftUI

enum ConfirmationSetting {
    enum SectionHeader {
        static var foregroundColor: Color = .gray
    }
    
    enum ListView {
        static var backgroundColor: Color = .white
        static var rowsBackgroundColor: Color = Color(.lightGray).opacity(0.4)
        static var lineSeperator: Visibility = .hidden
        static var actionButtonTitle: String = "Confirm"
        static var actionButtonColor: Color = .black
        static var actionButtonTitleColor: Color = .white
        static var actionButtonCornerRadius: CGFloat = 10
    }
    
    enum RowView {
        static var keyTextFont: Font = .headline
        static var keyTextForgroundColor: Color = .black
        static var valueTextFont: Font = .subheadline
        static var valueTextForgroundColor: Color = .gray
        
    }
}
