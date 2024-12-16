//
//  FormButtonView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

public struct FormButtonView: View {
    let title: String
    let buttonColor: ColorStyle
    let titleColor: Color
    let cornerRadius: Double
    var isDisabled: Bool = false
    var completion: (() -> Void)?
    
    public var body: some View {
        Button(action: {
            completion?()
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(titleColor)
                .background(backgroundView)
                .cornerRadius(cornerRadius)
                .padding(.top, 15)
        })
        .disabled(isDisabled)
    }
}

// MARK: - SubViews

private extension FormButtonView {
    @ViewBuilder
    var backgroundView: some View {
        switch buttonColor {
        case .normal(let color):
            color
        case let .gradient(gradient, startPoint, endPoint):
            LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
        }
    }
}
