//
//  FormToggleViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 07/09/2024.
//

import SwiftUI

protocol FormToggleConfigurable: ObservableObject {
    var isOn: Bool { get set }
    var label: String { get }
}

class FormToggleViewModel: FormToggleConfigurable {
    @Published var isOn: Bool
    var label: String
    
    init(isOn: Bool = false, label: String) {
        self.isOn = isOn
        self.label = label
    }
}
