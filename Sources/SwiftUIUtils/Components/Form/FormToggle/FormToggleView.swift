//
//  FormToggleView.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 06/09/2024.
//

import SwiftUI

public struct FormToggleView<ViewModel: FormToggleConfigurable>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var settings: FormSetting = .default

    /// Public initializer to inject the view model.
    public init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Toggle(isOn: $viewModel.isOn) {
            Text(viewModel.label)
                .foregroundStyle(settings.toggle.titleColor)
                .font(settings.toggle.titleFont)
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    FormToggleView(
        viewModel: FormToggleViewModel(isOn: true, label: "Any Label")
    )
}
