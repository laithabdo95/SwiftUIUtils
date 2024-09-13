//
//  FormFieldView.swift
//  Example1
//
//  Created by Laith Abdo on 03/08/2024.
//

import SwiftUI

struct FormFieldView<ViewModel: FormFieldConfigurable>: View {
    
    // MARK: Properties
    
    @FocusState private var focused: Bool
    @StateObject var viewModel: ViewModel
    @State private var isSecured: Bool = false
    @EnvironmentObject var formManager: FormManager

    private var placeHolder: String { isActive ? "" : viewModel.placeholder }
    var onTapGesture: (() -> Void)?

    private var isActive: Bool {
        focused || !viewModel.text.isEmpty
    }

    var body: some View {
        VStack {
            HeaderView()
            FieldView()
                .padding(.bottom, 15)
        }
        .onTapGesture {
            handleTapGesture()
        }
        .registerView(viewModel)
    }
}

// MARK: - SubViews

private extension FormFieldView {
    func HeaderView() -> some View {
        HStack {
            Text(viewModel.placeholder)
                .foregroundStyle(.secondary)
                .font(.subheadline)
                .opacity(isActive ? 1 : 0)
            Spacer()
            Text(viewModel.errorMessage)
                .foregroundStyle(.red)
                .font(.subheadline)
                .opacity(viewModel.isValid == .notValid ? 1 : 0)
        }
    }

    @ViewBuilder
    func FieldView() -> some View {
        ZStack(alignment: isActive ? .topLeading : .center) {
            HStack {
                InputField()
                if viewModel.fieldType.isPicker {
                    Image(systemName: viewModel.fieldType.imageName ?? "")
                } else if viewModel.fieldType == .secured {
                    SecuredToggleButton()
                }
            }
        }
        .disabled(viewModel.isEditingDisabled)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: FormSetting.FormField.cornerRadius)
                .stroke(
                    viewModel.isValid == .notValid ?
                    Color.red : FormSetting.FormField.borderColor,
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

    @ViewBuilder
    func InputField() -> some View {
        if viewModel.fieldType == .secured && isSecured {
            SecureField(
                placeHolder,
                text: $viewModel.text
            )
            .font(FormSetting.FormField.font)
            .keyboardType(viewModel.keyboardType)
            .focused($focused)
        } else {
            TextField(
                placeHolder,
                text: $viewModel.text
            )
            .font(FormSetting.FormField.font)
            .keyboardType(viewModel.keyboardType)
            .focused($focused)
        }
    }

    func SecuredToggleButton() -> some View {
        Button(action: {
            isSecured.toggle()
        }) {
            Image(systemName: !isSecured ? "eye.slash.fill" : "eye.fill")
                .foregroundColor(.gray)
        }
    }

    func handleTapGesture() {
        focused = true
        if viewModel.fieldType.isPicker {
            onTapGesture?()
        }
    }
}

// MARK: - Preview
#Preview {
    FormFieldView(viewModel: FormFieldViewModel(placeHolder: "Test", rules: []))
        .environmentObject(FormManager())
}
