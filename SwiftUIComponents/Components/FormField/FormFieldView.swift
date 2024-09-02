//
//  FormFieldView.swift
//  Example1
//
//  Created by Laith Abdo on 03/08/2024.
//

import SwiftUI

struct FormFieldView<ViewModel: FormFieldConfigurable>: View {
    
    // MARK: - Properties
    @FocusState private var focused: Bool
    @StateObject var viewModel: ViewModel
    @State private var isPasswordVisible: Bool = false
    
    private var placeHolder: String { isActive ? "" : viewModel.placeholder }
    
    var fieldType: FieldType { viewModel.fieldType }
    var onTapGesture: (() -> Void)?
    
    private var isActive: Bool {
        focused || !viewModel.text.isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            headerView
            FieldView()
                .padding([.leading, .trailing], 2)
                .padding(.bottom, 15)
        }
        .onTapGesture {
            handleTapGesture()
        }
    }
}

// MARK: - Subviews

private extension FormFieldView {
    @ViewBuilder
    private func FieldView() -> some View {
        ZStack(alignment: isActive ? .topLeading : .center) {
            HStack {
                inputField
                if fieldType == .picker {
                    Image(systemName: "chevron.down")
                } else if fieldType == .password {
                    passwordToggleButton
                }
            }
        }
        .disabled(viewModel.isEditingDisabled)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: FormSetting.FormField.cornerRadius)
                .stroke(
                    viewModel.isValid ?
                    FormSetting.FormField.borderColor :
                        Color.red,
                    lineWidth: 1
                )
                .background(
                    viewModel.isDisabled ?
                    FormSetting.FormField.disabledColor :
                        FormSetting.FormField.backgroundColor
                )
        )
        .animation(.linear(duration: 0.2), value: focused)
    }
    
    private var headerView: some View {
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
    }
    
    @ViewBuilder
    private var inputField: some View {
        if fieldType == .password && !isPasswordVisible {
            SecureField(
                placeHolder,
                text: $viewModel.text
            )
            .font(FormSetting.FormField.font)
            .focused($focused)
        } else {
            TextField(
                placeHolder,
                text: $viewModel.text
            )
            .font(FormSetting.FormField.font)
            .focused($focused)
        }
    }
    
    private var passwordToggleButton: some View {
        Button(action: {
            isPasswordVisible.toggle()
        }) {
            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Actions

private extension FormFieldView {
    private func handleTapGesture() {
        focused = true
        if fieldType == .picker {
            onTapGesture?()
        }
    }
}

// MARK: - Preview
#Preview {
    FormFieldView(viewModel: FormFieldViewModel(placeHolder: "Test", rules: []))
}
