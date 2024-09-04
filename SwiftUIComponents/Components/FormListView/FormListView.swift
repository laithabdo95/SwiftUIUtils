//
//  VerticalListView.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 29/08/2024.
//

import SwiftUI

protocol FormListItemValidatable: ObservableObject, Identifiable {
    var isValid: FormFieldViewModel.FieldStatus { get }
}

protocol FormListConfigurable: View {
    
    var primaryButtonTitle: String { get }
    var secondaryButtonTitle: String { get }
    var formManager: FormManager { get }
    
    func onPrimaryButtonTapped()
    func onSecondaryButtonTapped()
}

extension FormListConfigurable {
    var secondaryButtonTitle: String { "" }
    
    func onSecondaryButtonTapped() { }
}

struct FormListView<Configure: FormListConfigurable, Content: View>: View {
    @EnvironmentObject private  var formManager: FormManager
    
    private let configure: Configure
    private let content: Content
    
    init(configure: Configure, @ViewBuilder content: () -> Content) {
        self.configure = configure
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack {
                content
                Spacer(minLength: 45)
                ButtonView(
                    title: configure.primaryButtonTitle,
                    buttonColor: buttonColor,
                    titleColor: FormSetting.VerticalList.primaryButtonTitleColor,
                    cornerRadius: FormSetting.VerticalList.cornerRadius,
                    isDisabled: !formManager.isValid
                ) {
                    configure.onPrimaryButtonTapped()
                }
                if !configure.secondaryButtonTitle.isEmpty {
                    ButtonView(
                        title: configure.secondaryButtonTitle,
                        buttonColor: secondaryColor,
                        titleColor: FormSetting.VerticalList.secondaryButtonTitleColor,
                        cornerRadius: FormSetting.VerticalList.cornerRadius,
                        isDisabled: !formManager.isValid
                    ) {
                        configure.onSecondaryButtonTapped()
                    }
                }
            }
        }
        .padding(.horizontal, FormSetting.VerticalList.padding)
    }

    private var buttonColor: Color {
        formManager.isValid ? FormSetting.VerticalList.primaryButtonColor : FormSetting.VerticalList.buttonDisabledColor
    }

    private var secondaryColor: Color {
        formManager.isValid ? FormSetting.VerticalList.secondaryButtonColor : FormSetting.VerticalList.buttonDisabledColor
    }
}
