//
//  SwiftUIComponentsApp.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct SwiftUIComponentsApp: App {
    
    init() {
        IQKeyboardManager.shared.enable = true
        applyForm()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private extension SwiftUIComponentsApp {
    func applyForm() {
        FormSetting.FormField.cornerRadius = 25.0
    }
}
