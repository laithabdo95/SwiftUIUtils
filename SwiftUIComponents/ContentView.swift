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
        placeholder: "Select Your Gender",
        selectionViewModel: .init(
            options: ["Majd","Laith"],
            selectionType: .single
        )
    )
    
    var body: some View {
        VerticalListView {
            FormFieldView(viewModel: primaryViewModel)
            FormFieldView(viewModel: secondaryViewModel)
            FormPickerView(viewModel: genderSelectorViewModel)
            Spacer()
            ButtonView(title: "Hit Me") {
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
