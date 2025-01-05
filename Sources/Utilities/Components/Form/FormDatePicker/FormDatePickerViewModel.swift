//
//  FormDatePickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

public typealias FormDateAndFieldConfigurable = FormDatePickerConfigurable & FormFieldConfigurable

@MainActor
public protocol FormDatePickerConfigurable: AnyObject {
    associatedtype PickerStyle: DatePickerStyle
    
    var date: Date { get set }
    var dateType: DatePickerComponents { get }
    var datePickerStyle: PickerStyle { get }
    var dateStyle: DateFormatStyle { get }
}

public class FormDatePickerViewModel<PickerStyle: DatePickerStyle>: FormFieldViewModel, FormDatePickerConfigurable {
    public var dateStyle: DateFormatStyle
    public var datePickerStyle: PickerStyle
    public var dateType: DatePickerComponents
    
    @Published public var date: Date = Date() {
        didSet {
            text = dateStyle.format(date: date)
        }
    }
    
    public init(
        date: Date = Date(),
        dateType: DatePickerComponents = .date,
        datePickerStyle: PickerStyle = .graphical,
        dateStyle: DateFormatStyle = .medium,
        placeHolder: String,
        isDisabled: Bool = false,
        rules: [ValidationRule]
    ) {
        self.date = date
        self.dateType = dateType
        self.datePickerStyle = datePickerStyle
        self.dateStyle = dateStyle
        super.init(
            placeHolder: placeHolder,
            isDisabled: isDisabled,
            isEditingDisabled: true,
            rules: rules,
            fieldType: .datePicker
        )
    }
}
