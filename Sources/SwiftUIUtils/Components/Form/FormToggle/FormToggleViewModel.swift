//
//  FormToggleViewModel.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 07/09/2024.
//

import SwiftUI

public protocol FormToggleConfigurable: ObservableObject {
    var isOn: Bool { get set }
    var label: String { get }
}

public class FormToggleViewModel: FormToggleConfigurable {
    @Published public var isOn: Bool
    public var label: String
    
    public init(isOn: Bool = false, label: String) {
        self.isOn = isOn
        self.label = label
    }
}
