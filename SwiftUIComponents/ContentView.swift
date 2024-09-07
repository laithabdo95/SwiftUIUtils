//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

struct ContentView: FormListConfigurable {
    @State private var showLoading = false

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
    
    var annualToggle = FormToggleViewModel(label: "Annal Promotions")

    var body: some View {
        FormListView(configure: self) {
            FormFieldView(viewModel: primaryViewModel)
            FormFieldView(viewModel: secondaryViewModel)
            FormPickerView(viewModel: genderSelectorViewModel)
            FormDatePickerView(viewModel: birthDateViewModel)
            FormFieldView(viewModel: secureFieldViewModel)
            FormToggleView(viewModel: annualToggle)
        }
//        .fullScreenCover(isPresented: $showLoading, content: {
//            LoadingView()
//        })
//        .transaction({ transaction in
//            transaction.disablesAnimations = true
//        })
    }
    
    var parameter: [String: Any] {
        [:]
    }

    var primaryButtonTitle: String {
        "Submit"
    }

    var secondaryButtonTitle: String {
        "Save"
    }

    func onPrimaryButtonTapped() {
        showLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            showLoading = false
        }
    }

    func onSecondaryButtonTapped() { }
}

#Preview {
    ContentView()
}
