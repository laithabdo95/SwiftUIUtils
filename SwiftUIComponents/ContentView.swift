//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI
 
struct ContentView: FormListConfigurable {
    
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
    
    var genderSelectorViewModel = FormPickerViewModel(
        placeholder: "Please select your gender",
        selectionViewModel: SelectionViewModel(
            items: MaritalStatusEnum.allCases,
            selectionType: .single
        )
    )
    
    var birthDateViewModel = FormDatePickerViewModel(
        datePickerStyle: .graphical,
        placeHolder: "Select Your Birth Date",
        rules: [.required]
    )
    
    var secureFieldViewModel = FormFieldViewModel(
            placeHolder: "Password",
            rules: [.required],
            fieldType: .secured
        )
    
    var body: some View {
        FormListView(configure: self) {
            FormFieldView(viewModel: primaryViewModel)
            FormFieldView(viewModel: secondaryViewModel)
            FormPickerView(viewModel: genderSelectorViewModel)
            FormDatePickerView(viewModel: birthDateViewModel)
            FormFieldView(viewModel: secureFieldViewModel)
            .alert(genderSelectorViewModel.text, isPresented: $showAlert) {
                Text("Close")
            }
        }
    }
    
    func onPrimaryButtonTapped() {
        showAlert = true
        print("Primary Tapped")
    }
    
    var primaryButtonTitle: String {
        "Submit"
    }
    
    var secondaryButtonTitle: String {
        "Re-Submit"
    }
    
    func onSecondaryButtonTapped() {
        print("Secondary Tapped")
    }
}
 
#Preview {
    ContentView()
}
