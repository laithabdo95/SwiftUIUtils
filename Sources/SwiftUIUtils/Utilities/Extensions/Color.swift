//
//  Color.swift
//  SwiftUIUtils
//
//  Created by Mohammad Farhan on 17/04/2025.
//

public extension Color {
    /// Generates a random color with fixed saturation and brightness values for visual consistency.
    ///
    /// - Hue is randomized within the full spectrum (0 to 1).
    /// - Saturation is fixed at 0.7 for moderate color intensity.
    /// - Brightness is fixed at 0.9 for a bright appearance.
    ///
    /// Useful for generating visually appealing placeholder or tag colors.
    ///
    /// Example:
    /// ```swift
    /// let color = Color.random
    /// ```
    static var random: Color {
        return Color(hue: .random(in: 0...1), saturation: 0.7, brightness: 0.9)
    }
}
