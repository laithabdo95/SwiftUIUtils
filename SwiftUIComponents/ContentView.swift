//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

struct ContentView: View, FormListConfigurable {
    @StateObject private var formManager = FormManager()
    @State private var showAlert = false

    @StateObject var primaryViewModel = FormFieldViewModel(
        placeHolder: "Primary Email",
        isDisabled: false,
        rules: [.required, .regex(.email)]
    )

    @StateObject var secondaryViewModel = FormFieldViewModel(
        placeHolder: "Middle Name",
        rules: []
    )

    @StateObject var genderSelectorViewModel = FormPickerViewModel(
        placeholder: "Please select your gender",
        selectionViewModel: SelectionViewModel(
            items: MaritalStatusEnum.allCases,
            selectionType: .single
        )
    )

    @StateObject var birthDateViewModel = FormDatePickerViewModel(
        datePickerStyle: .graphical,
        placeHolder: "Select Your Birth Date",
        rules: [.required]
    )

    @StateObject var secureFieldViewModel = FormFieldViewModel(
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
        .environmentObject(formManager)
    }

    var primaryButtonTitle: String {
        "Submit"
    }

    var secondaryButtonTitle: String {
        ""
    }

    func onPrimaryButtonTapped() {
        showAlert = true
        print("Primary Tapped")
    }

    func onSecondaryButtonTapped() { }
}

#Preview {
    ContentView()
}
