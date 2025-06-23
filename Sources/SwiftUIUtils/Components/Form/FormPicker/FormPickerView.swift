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

    public init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        FormFieldView(viewModel: viewModel) {
				viewModel.bindSelectionViewModel()
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                SelectionView(viewModel: viewModel.selectionViewModel)
                    .presentationDetents([.medium])
            }
    }
}
