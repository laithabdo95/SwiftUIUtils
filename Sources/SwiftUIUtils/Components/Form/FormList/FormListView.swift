//
//  VerticalListView.swift
//  SwiftUIUtils
//
//  Created by Majd Aldawoud on 29/08/2024.
//

import SwiftUI

public protocol FormListItemValidatable: ObservableObject, Identifiable {
    var isValid: FormFieldViewModel.FieldStatus { get }
}

public protocol FormListConfigurable {
    
    var primaryButtonTitle: String { get }
    var secondaryButtonTitle: String { get }
    
    func onPrimaryButtonTapped()
    func onSecondaryButtonTapped()
    
    associatedtype Parameter
    var parameter: Parameter { get }
    
    associatedtype Content: View
    var formBody: FormListView<Self, Content> { get }
}

public extension FormListConfigurable {
    var secondaryButtonTitle: String { "" }
    
    func onSecondaryButtonTapped() { }
}

public struct FormListView<Configure: FormListConfigurable, Content: View>: View {
    @Environment(FormManager.self) private var formManager
    @State var settings: FormSetting = .default
    private let configure: Configure
    private let content: Content
    @Binding private var isLoading: Bool
    
    public init(
        configure: Configure,
        isLoading: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self.configure = configure
        self.content = content()
        self._isLoading = isLoading
    }

    public var body: some View {
        ScrollView {
            VStack {
                content
                Spacer(minLength: 45)
                FormButtonView(
                    settings: .init(primaryButton: .init(backgroundColor: buttonColor)),
                    title: configure.primaryButtonTitle,
                    isDisabled: !formManager.isValid
                ) {
                    configure.onPrimaryButtonTapped()
                }
                if !configure.secondaryButtonTitle.isEmpty {
                    FormButtonView(
                        settings: .init(
                            primaryButton: .init(backgroundColor: secondaryColor)
                        ),
                        title: configure.secondaryButtonTitle,
                        isDisabled: !formManager.isValid
                    ) {
                        configure.onSecondaryButtonTapped()
                    }
                }
            }
        }
        .environment(formManager)
        .padding(.horizontal, settings.verticalList.padding)
        .fullScreenCover(isPresented: $isLoading, content: {
            LoadingView()
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }

    private var buttonColor: ColorStyle {
        formManager.isValid ?
        settings.verticalList.primaryButtonColor :
        .normal(settings.verticalList.buttonDisabledColor)
    }

    private var secondaryColor: ColorStyle {
        formManager.isValid ?
        settings.verticalList.secondaryButtonColor :
        .normal(settings.verticalList.buttonDisabledColor)
    }
}
