//
//  FormPickerView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

struct FormPickerView: View {
    
    @State private var isSheetPresented: Bool = false
    @StateObject var viewModel: FormPickerViewModel = FormPickerViewModel(
        placeholder: "Marital Status",
        isRequired: true,
        selectionViewModel: .init(options: ["Majd", "Laith"])
    )
    
    var body: some View {
        FormFieldView(
            viewModel: viewModel,
            fieldType: .picker) {
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                SelectionView(viewModel: viewModel.selectionViewModel)
            }
    }
}

#Preview {
    FormPickerView()
}
