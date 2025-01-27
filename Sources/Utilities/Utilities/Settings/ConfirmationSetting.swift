//
//  ConfirmationSetting.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 27/10/2024.
//

import SwiftUI

public enum ConfirmationSetting {
    @MainActor
    enum SectionHeader {
        
        static var foregroundColor: Color = .gray
    }
    
    @MainActor
    public enum ListView {
        public static var backgroundColor: Color = .white
        public static var rowsBackgroundColor: Color = Color(.lightGray).opacity(0.4)
        public static var lineSeperator: Visibility = .hidden
        public static var actionButtonTitle: String = "Confirm"
        public static var actionButtonColor: Color = .black
        public static var actionButtonTitleColor: Color = .white
        public static var actionButtonCornerRadius: CGFloat = 10
    }
    
    @MainActor
    public enum RowView {
        public static var keyTextFont: Font = .headline
        public static var keyTextForgroundColor: Color = .black
        public static var valueTextFont: Font = .subheadline
        public static var valueTextForgroundColor: Color = .gray
    }
}
