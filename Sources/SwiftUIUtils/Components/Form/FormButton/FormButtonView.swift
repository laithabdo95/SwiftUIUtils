//
//  FormButtonView.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

public struct FormButtonView: View {
    @State var settings: FormSetting = .default
    let title: String
    var isDisabled: Bool = false
    var completion: (() -> Void)?
    
    public var body: some View {
        Button(action: {
            completion?()
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(settings.primaryButton.titleColor)
                .background(backgroundView)
                .cornerRadius(settings.primaryButton.cornerRadius)
                .padding(.top, 15)
        })
        .disabled(isDisabled)
        .padding(.top, settings.primaryButton.padding.top)
        .padding(.bottom, settings.primaryButton.padding.bottom)
        .padding(.leading, settings.primaryButton.padding.leading)
        .padding(.trailing, settings.primaryButton.padding.trailing)
    }
}

// MARK: - SubViews

private extension FormButtonView {
    @ViewBuilder
    var backgroundView: some View {
        switch settings.primaryButton.backgroundColor {
        case .normal(let color):
            color
        case let .gradient(gradient, startPoint, endPoint):
            LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
        }
    }
}
