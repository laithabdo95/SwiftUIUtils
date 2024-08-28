//
//  FormField.swift
//  Example1
//
//  Created by Laith Abdo on 03/08/2024.
//

import SwiftUI


struct FormField: View {
    
    @FocusState var focused: Bool
    @StateObject var viewModel: FormViewModel = FormViewModel(placeHolder: "", rules: [])
    
    var isActive: Bool {
        focused || viewModel.text.count > 0
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.placeholder)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .opacity(isActive ? 1 : 0)
                Spacer()
                Text(viewModel.errorMessage)
                    .foregroundStyle(.red)
                    .font(.subheadline)
                    .opacity(viewModel.isValid ? 0 : 1)
            }
            FieldView()
                .padding(.bottom, 15)
        }
    }
}

extension FormField {
    @ViewBuilder
    func FieldView() -> some View {
        ZStack(alignment: isActive ? .topLeading : .center) {
            TextField(
                isActive ? "" : viewModel.placeholder,
                text: $viewModel.text
            )
            .font(FormSetting.FormField.font)
            .focused($focused)
        }
        .onTapGesture {
            focused = true
        }
        .disabled(viewModel.isDisabled)
        .animation(.linear(duration: 0.2), value: focused)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: FormSetting.FormField.cornerRadius)
                .stroke(
                    viewModel.isValid ? FormSetting.FormField.borderColor : Color.red,
                    lineWidth: 1
                )
                .fill(
                    viewModel.isDisabled ? FormSetting.FormField.disabledColor : FormSetting.FormField.backgroundColor
                )
        )
    }
}


#Preview {
    FormField()
}
