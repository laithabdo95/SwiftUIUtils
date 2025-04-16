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
    
    public var body: some View {
        FormFieldView(viewModel: viewModel) {
                isSheetPresented = true
            }
            .fullScreenCover(isPresented: $isSheetPresented) {
                SelectionView(viewModel: viewModel.selectionViewModel)
            }
    }
}
