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
    
    let genderSelectorViewModel = FormPickerViewModel(
        placeholder: "Select Your Gender"
    )
    
    let genderSelectionViewModel = SelectionViewModel(
        options: MaritalStatusEnum.allCases.map(
            \.rawValue
        ),
        selectionType: .single
    )
    
    var body: some View {
        ScrollView {
            VStack {
                FormFieldView(viewModel: primaryViewModel)
                FormFieldView(viewModel: secondaryViewModel)
                FormPickerView(viewModel: genderSelectorViewModel, selectionViewModel: genderSelectionViewModel)
                Spacer()
                ButtonView(title: "Hit Me") {
                    showAlert = true
                }
                .alert(primaryViewModel.text, isPresented: $showAlert) {
                    Text("Close")
                }
            }
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    ContentView()
}

struct ButtonView: View {
    let title: String
    var completion: (() -> Void)?
    
    var body: some View {
        Button(action: {
            completion?()
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(12)
        })
    }
}
