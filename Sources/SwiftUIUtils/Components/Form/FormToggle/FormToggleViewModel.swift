//
//  FormToggleViewModel.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 07/09/2024.
//

import SwiftUI
import Observation

@Observable
public class FormToggleViewModel {
    public var isOn: Bool
    public var label: String
    
    public init(
        isOn: Bool = false,
        label: String
    ) {
        self.isOn = isOn
        self.label = label
    }
}
