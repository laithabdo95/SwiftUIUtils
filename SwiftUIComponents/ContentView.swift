//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoading = false
    @State private var showProgress = false
    
    @State var currentUploadItem = 0
    var attachemnts = Array(1...4)
    @State private var timer: Timer? = nil
    
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
        dateStyle: .full,
        placeHolder: "Select Your Birth Date",
        rules: [.required]
    )

    @StateObject var secureFieldViewModel = FormFieldViewModel(
        placeHolder: "Password",
        rules: [.required],
        fieldType: .secured
    )
    
    @StateObject var progressViewModel = MockupProgressViewModel(items: [
        Mockup(name: "Lait Abdo", age: 29),
        Mockup(name: "Majd Dawood", age: 29),
        Mockup(name: "Mohammad Farhan", age: 30)
    ]) {
        
    }
    
    var annualToggle = FormToggleViewModel(label: "Annal Promotions")

    var body: some View {
        formBody
        .fullScreenCover(isPresented: $showProgress, content: {
            ProgressLoaderView(viewModel: progressViewModel)
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
}

extension ContentView: FormListConfigurable {
    
    var formBody: FormListView<ContentView, some View> {
        FormListView(configure: self, isLoading: $showLoading) {
            FormFieldView(viewModel: primaryViewModel)
            FormFieldView(viewModel: secondaryViewModel)
            FormPickerView(viewModel: genderSelectorViewModel)
            FormDatePickerView(viewModel: birthDateViewModel)
            FormFieldView(viewModel: secureFieldViewModel)
            FormToggleView(viewModel: annualToggle)
        }
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

    func onSecondaryButtonTapped() {
        showProgress = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation {
                currentUploadItem += 1
            }
            if currentUploadItem == attachemnts.count {
                timer?.invalidate()
                timer = nil
            }
        }
    }
}

#Preview {
    ContentView()
}


struct Mockup: Codable {
    let name: String
    let age: Int
}
