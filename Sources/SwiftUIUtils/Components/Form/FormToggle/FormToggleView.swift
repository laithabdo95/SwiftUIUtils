//
//  FormToggleView.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 06/09/2024.
//

import SwiftUI

public struct FormToggleView<Style: ToggleStyle>: View {
    
    // MARK: Properties
    @Bindable private var viewModel: FormToggleViewModel
    var style: Style
    var settings: FormSetting
    
    // MARK: Init
    public init(
        viewModel: FormToggleViewModel,
        settings: FormSetting,
        style: Style = SwitchToggleStyle()
    ) {
        self.viewModel = viewModel
        self.settings = settings
        self.style = style
    }
}

// MARK: - Body
public extension FormToggleView {
    var body: some View {
        Toggle(isOn: $viewModel.isOn) {
            Text(viewModel.label)
                .foregroundStyle(settings.toggle.titleColor)
                .font(settings.toggle.font)
        }
        .toggleStyle(style)
        .padding(.leading, settings.toggle.padding.leading)
        .padding(.trailing, settings.toggle.padding.trailing)
        .padding(.top, settings.toggle.padding.top)
        .padding(.bottom, settings.toggle.padding.bottom)
    }
}

// MARK: - Conditional Init Extenison
public extension FormToggleView where Style == CompactToggleStyle {
    init(
        viewModel: FormToggleViewModel,
        settings: FormSetting = .default
    ) {
        self.init(
            viewModel: viewModel,
            settings: settings,
            style: CompactToggleStyle(settings: settings)
        )
    }
}
