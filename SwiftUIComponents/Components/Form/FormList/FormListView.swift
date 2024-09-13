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

protocol FormListConfigurable {
    
    var primaryButtonTitle: String { get }
    var secondaryButtonTitle: String { get }
    
    func onPrimaryButtonTapped()
    func onSecondaryButtonTapped()
    
    associatedtype Parameter
    var parameter: Parameter { get }
    
    associatedtype Content: View
    var formBody: FormListView<Self, Content> { get }
}

extension FormListConfigurable {
    var secondaryButtonTitle: String { "" }
    
    func onSecondaryButtonTapped() { }
}

struct FormListView<Configure: FormListConfigurable, Content: View>: View {
    @StateObject private  var formManager: FormManager = FormManager()
    
    private let configure: Configure
    private let content: Content
    @Binding private var isLoading: Bool
    
    init(configure: Configure, isLoading: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.configure = configure
        self.content = content()
        self._isLoading = isLoading
    }

    var body: some View {
        ScrollView {
            VStack {
                content
                Spacer(minLength: 45)
                FormButtonView(
                    title: configure.primaryButtonTitle,
                    buttonColor: buttonColor,
                    titleColor: FormSetting.VerticalList.primaryButtonTitleColor,
                    cornerRadius: FormSetting.VerticalList.cornerRadius,
                    isDisabled: !formManager.isValid
                ) {
                    configure.onPrimaryButtonTapped()
                }
                if !configure.secondaryButtonTitle.isEmpty {
                    FormButtonView(
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
        .environmentObject(formManager)
        .padding(.horizontal, FormSetting.VerticalList.padding)
        .fullScreenCover(isPresented: $isLoading, content: {
            LoadingView()
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }

    private var buttonColor: Color {
        formManager.isValid ? FormSetting.VerticalList.primaryButtonColor : FormSetting.VerticalList.buttonDisabledColor
    }

    private var secondaryColor: Color {
        formManager.isValid ? FormSetting.VerticalList.secondaryButtonColor : FormSetting.VerticalList.buttonDisabledColor
    }
}
