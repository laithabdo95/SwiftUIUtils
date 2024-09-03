//
//  ButtonView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let buttonColor: Color
    let titleColor: Color
    let cornerRadius: Double
    var isDisabled: Bool = false
    var completion: (() -> Void)?
    
    var body: some View {
        Button(action: {
            completion?()
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(titleColor)
                .background(buttonColor)
                .cornerRadius(cornerRadius)
        })
        .disabled(isDisabled)
    }
}
