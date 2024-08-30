//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI
 
struct ContentView: View {
    
    @State private var showAlert = false
    
    let primaryViewModel = FormFieldViewModel(
        placeHolder: "Primary Email",
        isDisabled: false,
        rules: [
            .required,
            .regex(
                .email
            )
        ]
    )
    let secondaryViewModel = FormFieldViewModel(
        placeHolder: "Middle Name",
        rules: []
    )
    
    var genderSelectorViewModel: FormPickerViewModel<MaritalStatusEnum> {
        FormPickerViewModel(
            placeholder: "Please select your gender",
            selectionViewModel: SelectionViewModel(
                items: MaritalStatusEnum.allCases,
                selectionType: .single
            )
        )
    }
    
    var birthDateViewModel = FormDatePickerViewModel(
        datePickerStyle: .graphical,
        placeHolder: "Select Your Birth Date",
        rules: [.required]
    )
    
    var body: some View {
        VerticalListView {
            FormFieldView(viewModel: primaryViewModel)
            FormFieldView(viewModel: secondaryViewModel)
            FormPickerView(viewModel: genderSelectorViewModel)
            FormDatePickerView(viewModel: birthDateViewModel)
            Spacer()
            ButtonView(
                title: "Confirm",
                buttonColor: FormSetting.VerticalList.primaryButtonColor,
                titleColor: FormSetting.VerticalList.primaryButtonTitleColor,
                cornerRadius: FormSetting.VerticalList.cornerRadius
            ) {
                showAlert = true
            }
            .alert(genderSelectorViewModel.text, isPresented: $showAlert) {
                Text("Close")
            }
        }
    }
}
 
#Preview {
    ContentView()
}
