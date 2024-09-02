//
//  FormDatePickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

typealias FormDateAndFieldConfigurable = FormDatePickerConfigurable & FormFieldConfigurable

protocol FormDatePickerConfigurable: AnyObject {
    associatedtype PickerStyle: DatePickerStyle
    
    var date: Date { get set }
    var dateType: DatePickerComponents { get }
    var datePickerStyle: PickerStyle { get }
}

class FormDatePickerViewModel<PickerStyle: DatePickerStyle>: FormFieldViewModel, FormDatePickerConfigurable {
    var datePickerStyle:PickerStyle
    var dateType: DatePickerComponents
    
    @Published var date: Date = Date() {
        didSet {
            text = date.formatted()
        }
    }
    
    init(
        date: Date = Date(),
        dateType: DatePickerComponents = .date,
        datePickerStyle: PickerStyle = .graphical,
        placeHolder: String,
        isDisabled: Bool = false,
        rules: [ValidationRule]
    ) {
        self.date = date
        self.dateType = dateType
        self.datePickerStyle = datePickerStyle
        super.init(
            placeHolder: placeHolder,
            isDisabled: isDisabled,
            isEditingDisabled: true,
            rules: rules,
            fieldType: .picker
        )
    }
}
