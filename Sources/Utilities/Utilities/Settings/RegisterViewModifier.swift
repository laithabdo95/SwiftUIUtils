//
//  RegisterViewModifier.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 04/09/2024.
//

import SwiftUI

public struct RegisterViewModifier<ViewModel: FormFieldConfigurable>: ViewModifier {
    @EnvironmentObject var formManager: FormManager
    @ObservedObject var viewModel: ViewModel

    public func body(content: Content) -> some View {
        content
            .onAppear {
                formManager.register(viewModel)
            }
            .onDisappear {
                formManager.unregister(viewModel)
            }
    }
}

public extension View {
    func registerView<ViewModel: FormFieldConfigurable>(_ viewModel: ViewModel) -> some View {
        self.modifier(RegisterViewModifier(viewModel: viewModel))
    }
}
