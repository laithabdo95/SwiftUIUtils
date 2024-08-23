//
//  FormField.swift
//  Example1
//
//  Created by Laith Abdo on 03/08/2024.
//

import SwiftUI


struct FormField: View {
    
    let placeholder: String
    
    @FocusState var focused: Bool
    @StateObject var viewModel = TextValidator()
    
    var isActive: Bool {
        focused || viewModel.text.count > 0
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(placeholder)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .opacity(isActive ? 1 : 0)
                Spacer()
                Text("Wrong Data")
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
            TextField(isActive ? "" : placeholder, text: $viewModel.text)
                .font(.system(size: 16, weight: .regular))
                .focused($focused)
        }
        .onTapGesture {
            focused = true
        }
        .animation(.linear(duration: 0.2), value: focused)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.secondary, lineWidth: 1)
        )
    }
}


#Preview {
    FormField(placeholder: "Username")
}


extension Binding {
    static func defaultValue(_ value: Value) -> Binding<Value> {
        return Binding(
            get: { value },
            set: { _ in }
        )
    }
}
