//
//  VerticalListView.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 29/08/2024.
//

import SwiftUI

protocol FormListConfigurable: View {
    
    var primaryButtonTitle: String { get }
    var secondaryButtonTitle: String { get }
    
    func onPrimaryButtonTapped()
    func onSecondaryButtonTapped()
    
    var validatedItems: [FormFieldViewModel.FieldStatus] { get }
}

extension FormListConfigurable {
    var secondaryButtonTitle: String { "" }
    
    func onSecondaryButtonTapped() { }
}

struct FormListView<Configure: FormListConfigurable, Content: View>: View {
    let configure: Configure
    private var isValid: Bool {
        configure.validatedItems.allSatisfy { $0 == .valid }
    }
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollView {
            VStack {
                content()
                Spacer(minLength: 45)
                ButtonView(
                    title: configure.primaryButtonTitle,
                    buttonColor: buttonColor,
                    titleColor: FormSetting.VerticalList.primaryButtonTitleColor,
                    cornerRadius: FormSetting.VerticalList.cornerRadius,
                    isDisabled: !isValid
                ) {
                    configure.onPrimaryButtonTapped()
                }
                if !configure.secondaryButtonTitle.isEmpty {
                    ButtonView(
                        title: configure.secondaryButtonTitle,
                        buttonColor: secondaryColor,
                        titleColor: FormSetting.VerticalList.secondaryButtonTitleColor,
                        cornerRadius: FormSetting.VerticalList.cornerRadius,
                        isDisabled: !isValid
                    ) {
                        configure.onSecondaryButtonTapped()
                    }
                }
            }
        }
        .padding(.horizontal, FormSetting.VerticalList.padding)
    }
}

extension FormListView {
    var buttonColor: Color {
        isValid ? FormSetting.VerticalList.primaryButtonColor : FormSetting.VerticalList.buttonDisabledColor
    }
    
    var secondaryColor: Color {
        isValid ? FormSetting.VerticalList.secondaryButtonColor : FormSetting.VerticalList.buttonDisabledColor
    }
}
