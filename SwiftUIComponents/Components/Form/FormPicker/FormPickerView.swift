//
//  FormPickerView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

struct FormPickerView<ViewModel: FormPickerAndFieldConfigurable>: View {
    
    @State private var isSheetPresented: Bool = false
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        FormFieldView(viewModel: viewModel) {
                isSheetPresented = true
            }
            .fullScreenCover(isPresented: $isSheetPresented) {
                SelectionView(viewModel: viewModel.selectionViewModel)
            }
    }
}

#Preview {
    FormPickerView(
        viewModel: FormPickerViewModel(
            placeholder: "Marital Status",
            selectionViewModel: SelectionViewModel(
                items: MaritalStatusEnum.allCases,
                selectionType: .single
            )
        )
    )
    .environmentObject(FormManager())
}
