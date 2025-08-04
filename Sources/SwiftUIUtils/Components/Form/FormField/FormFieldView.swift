//
//  FormFieldView.swift
//  Example1
//
//  Created by Laith Abdo on 03/08/2024.
//

import SwiftUI
import CoreUtils

public struct FormFieldView<ViewModel: FormFieldConfigurable>: View {
    
    // MARK: Properties
    @State var settings: FormSetting = .default
    @FocusState private var focused: Bool
    @ObservedObject var viewModel: ViewModel
    @State private var isSecured: Bool = true
    @Environment(FormManager.self) private var formManager

    private var placeHolder: String { isActive ? "" : viewModel.placeholder ?? viewModel.title }
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
                .contentShape(Rectangle())
                .onTapGesture {
                    handleTapGesture()
                }
            if viewModel.errorMessage.isNotEmpty {
                FooterView()
            }
        }
        .animation(.bouncy, value: viewModel.errorMessage)
        .registerView(viewModel)
    }
}

// MARK: - SubViews

public extension FormFieldView {
    func HeaderView() -> some View {
        HStack {
            if viewModel.title.isNotEmpty {
                Text(viewModel.title)
                    .foregroundStyle(viewModel.isValid == .notValid ? .red : settings.formField.titleColor )
                    .font(settings.formField.titleFont)
            }
            Spacer()
        }
    }
    
    func FooterView() -> some View {
        HStack {
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
        .background(viewModel.isDisabled ? settings.formField.disabledColor :
                        settings.formField.backgroundColor)
        .cornerRadius(settings.formField.cornerRadius)
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
        } else if viewModel.fieldType == .expiryDate {
            TextField(
                    placeHolder,
                    text: $viewModel.text
                )
                .font(settings.formField.font)
                .keyboardType(.numberPad)
                .focused($focused)
                .onChange(of: viewModel.text) { oldValue, newValue in
                    viewModel.text = newValue.formattedAsExpiryDate()
                }
        } else {
            TextField(
                placeHolder,
                text: $viewModel.text
            )
            .foregroundStyle(settings.formField.textColor)
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
    FormFieldView(viewModel: FormFieldViewModel(title: "Farhan", placeHolder: "Test", rules: []))
        .environment(FormManager())
}

