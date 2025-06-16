//
//  CompactToggleStyle.swift
//  SwiftUIUtils
//
//  Created by Majd Aldawoud on 15/06/2025.
//

import SwiftUI

/// A compact toggle style that mimics a switch-like appearance using a customizable rectangle and thumb.
///
/// This style is intended for use in form rows or other compact UI contexts.
/// It uses colors, sizes, and radii defined in `FormSetting.toggle`.
public struct CompactToggleStyle {
    
    // MARK: Properites
    private var settings: FormSetting
    
    /// Initializes a new instance of `CompactToggleStyle` with the provided form settings.
    /// - Parameter settings: A `FormSetting` instance containing toggle-related appearance values.
    public init(settings: FormSetting) {
        self.settings = settings
    }
}

// MARK: - Configure
extension CompactToggleStyle: ToggleStyle {
    /// Creates the view representing the toggle.
    /// - Parameter configuration: The configuration of the toggle including its state and label.
    /// - Returns: A view that represents the body of the toggle.
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .fill(
                    configuration.isOn
                    ? settings.toggle.enabledColor
                    : settings.toggle.disabledColor
                )
                .frame(
                    width: settings.toggle.size.width,
                    height: settings.toggle.size.height
                )
                .cornerRadius(settings.toggle.cornerRadius)
                .overlay(
                    Circle()
                        .fill(settings.toggle.thumbColor)
                        .shadow(radius: 1)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .opacity(1)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
