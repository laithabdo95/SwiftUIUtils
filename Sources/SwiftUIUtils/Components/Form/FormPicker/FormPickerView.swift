//
//  FormPickerView.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

public struct FormPickerView<ViewModel: FormPickerAndFieldConfigurable>: View {
    
    @State private var isSheetPresented: Bool = false
    @ObservedObject var viewModel: ViewModel
    
    /// Public initializer to inject the view model.
    public init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        FormFieldView(viewModel: viewModel) {
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                SelectionView(viewModel: viewModel.selectionViewModel)
                    .presentationDetents([.medium])
            }
    }
}
