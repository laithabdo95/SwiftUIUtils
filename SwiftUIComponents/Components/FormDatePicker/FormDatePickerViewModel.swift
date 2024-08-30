//
//  FormDatePickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

typealias FormDateAndFieldConfigurable = FormDatePickerConfigurable & FormFieldConfigurable

protocol FormDatePickerConfigurable {
    var date: Date { get set }
}

class FormDatePickerViewModel: FormFieldViewModel, FormDatePickerConfigurable {
    @Published var date: Date = Date()
    
    init(date: Date = Date(), placeHolder: String, isDisabled: Bool = false, rules: [ValidationRule]) {
        self.date = date
        super.init(placeHolder: placeHolder, isDisabled: isDisabled, rules: rules)
    }
}
