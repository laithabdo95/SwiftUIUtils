//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = false
    let primaryEmailValidator = FormViewModel(
        placeHolder: "Primary Email",
        isDisabled: true,
        rules: [
            .required,
            .regex(
                .email
            )
        ]
    )
    let secondaryEmailValidator = FormViewModel(
        placeHolder: "Middle Name",
        rules: []
    )
    
    var body: some View {
        VStack {
            FormField(viewModel: primaryEmailValidator)
            FormField(viewModel: secondaryEmailValidator)
            Spacer()
            ButtonView(title: "Hit Me") {
                showAlert = true
            }
            .alert(primaryEmailValidator.text, isPresented: $showAlert) {
                Text("Close")
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
