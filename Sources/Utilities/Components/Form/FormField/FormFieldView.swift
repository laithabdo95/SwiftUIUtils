//
//  FormFieldView.swift
//  Example1
//
//  Created by Laith Abdo on 03/08/2024.
//

import SwiftUI

public struct FormFieldView<ViewModel: FormFieldConfigurable>: View {
    
    // MARK: Properties
    @State var settings: FormSetting = .default
    @FocusState private var focused: Bool
    @ObservedObject var viewModel: ViewModel
    @State private var isSecured: Bool = true
    @EnvironmentObject var formManager: FormManager

    private var placeHolder: String { isActive ? "" : viewModel.placeholder }
    var onTapGesture: (() -> Void)?

    private var isActive: Bool {
        focused || !viewModel.text.isEmpty
    }
    
    public init(
        viewModel: ViewModel,
        onTapGesture: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.onTapGesture = onTapGesture
    }

    public var body: some View {
        VStack {
            HeaderView()
            FieldView()
                .padding(.bottom, 15)
                .contentShape(Rectangle())
                .onTapGesture {
                    handleTapGesture()
                }
        }
        .registerView(viewModel)
    }
}

// MARK: - SubViews

public extension FormFieldView {
    func HeaderView() -> some View {
        HStack {
            Text(viewModel.placeholder)
                .foregroundStyle(viewModel.isValid == .notValid ? .red : settings.formField.titleColor )
                .font(settings.formField.titleFont)
            Spacer()
            Text(viewModel.errorMessage)
                .foregroundStyle(.red)
                .font(.subheadline)
                .opacity(viewModel.isValid == .notValid ? 1 : 0)
                .frame(height: 20)
        }
    }

    @ViewBuilder
    func FieldView() -> some View {
        HStack {
            InputField()
            if viewModel.fieldType.isPicker {
                Image(systemName: viewModel.fieldType.imageName ?? "")
            } else if viewModel.fieldType == .secured {
                SecuredToggleButton()
            }
        }
        .disabled(viewModel.isEditingDisabled)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: settings.formField.cornerRadius)
                .stroke(
                    viewModel.isValid == .notValid ?
                    Color.red : settings.formField.borderColor,
                    lineWidth: 1
                )
                .background(
                    viewModel.isDisabled ?
                    settings.formField.disabledColor :
                        settings.formField.backgroundColor
                )
        )
        .animation(.linear(duration: 0.2), value: focused)
        .padding(.leading, 1)
        .padding(.trailing, 1)
    }

    @ViewBuilder
    func InputField() -> some View {
        if viewModel.fieldType == .secured && isSecured {
            SecureField(
                placeHolder,
                text: $viewModel.text
            )
            .font(settings.formField.font)
            .keyboardType(viewModel.keyboardType)
            .focused($focused)
        } else {
            TextField(
                placeHolder,
                text: $viewModel.text
            )
            .font(settings.formField.font)
            .keyboardType(viewModel.keyboardType)
            .focused($focused)
        }
    }

    func SecuredToggleButton() -> some View {
        Button(action: {
            isSecured.toggle()
        }) {
            Image(systemName: !isSecured ? "eye.fill" : "eye.slash.fill")
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
