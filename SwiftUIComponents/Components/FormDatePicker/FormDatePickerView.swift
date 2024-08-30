//
//  FormDatePickerView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

struct FormDatePickerView<ViewModel: FormDateAndFieldConfigurable>: View  {
    @State private var showDatePicker = false
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                FormFieldView(viewModel: viewModel, fieldType: .picker) {
                    showDatePicker = true
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $showDatePicker, content: {
                VStack {
                    DatePicker(
                        "Select Date",
                        selection: $viewModel.date,
                        displayedComponents: viewModel.dateType
                    )
                    .datePickerStyle(viewModel.datePickerStyle)
                    .padding()
                    .background(Color.white)
                    
                    Button("Done") {
                        showDatePicker = false
                    }
                    .padding(.vertical, 15)
                }
                .background(Color.white)
                .cornerRadius(12)
                .frame(maxWidth: 300)
                .presentationBackground(Color.black.opacity(0.8))
            })
            .transaction({ transaction in
                transaction.disablesAnimations = true
            })
        }
    }
}

#Preview {
    FormDatePickerView(
        viewModel: FormDatePickerViewModel(
            placeHolder: "Select Birth Date",
            rules: []
        )
    )
}

