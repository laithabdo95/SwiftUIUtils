//
//  FormFieldViewModel.swift
//  Example1
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

public protocol FormFieldConfigurable: ObservableObject, FormListItemValidatable {
    var id: UUID { get }
    var title: String { get }
    var placeholder: String? { get }
    var rules: [ValidationRule] { get }
    var text: String { get set }
    var errorMessage: String { get }
    var isDisabled: Bool  { get }
    var isEditingDisabled: Bool { get }
    var fieldType: FormFieldViewModel.FieldType { get }
    var keyboardType: UIKeyboardType { get }
    
    func validate()
//    func getValidationResult() -> [ValidationResult]
}

public class FormFieldViewModel: FormFieldConfigurable {
    public var placeholder: String?
    public let fieldType: FieldType
    public var rules: [ValidationRule]
    public var id: UUID = UUID()
    public var keyboardType: UIKeyboardType
    @FormFieldTitle public var title: String
    
    @Published public var text: String = "" {
        didSet {
            validate()
        }
    }
    
    @Published public var isValid: FieldStatus = .notSet
    @Published public var errorMessage: String = ""
    @Published public var isDisabled: Bool = false
    @Published public var isEditingDisabled: Bool = false
    
    public func validate() {
        let result = rules.map { $0.validate(text: text) }
        isValid = result.allSatisfy { $0.isValid } ? .valid : .notValid
        errorMessage = result.first(where: { !$0.isValid })?.errorMessage ?? ""
    }
    
    public init(
        title: String = "",
        placeHolder: String = "",
        isDisabled: Bool = false,
        isEditingDisabled: Bool = false,
        rules: [ValidationRule],
        fieldType: FieldType = .field,
        keyboardType: UIKeyboardType = .default
    ) {
        self.title = title
        self.placeholder = placeHolder
        self.isDisabled = isDisabled
        self.isEditingDisabled = isEditingDisabled
        self.rules = rules
        self.fieldType = fieldType
        self.keyboardType = keyboardType
        self.$title.update(rules.isEmpty)
    }
}

public extension FormFieldViewModel {    
    enum FieldStatus {
        case notSet
        case valid
        case notValid
    }
    
    enum FieldType {
        case field
        case picker
        case secured
        case datePicker
        case expiryDate
        
        var imageName: String? {
            switch self {
            case .picker: return "chevron.down"
            case .datePicker: return "calendar"
            default: return nil
            }
        }
        
        var isPicker: Bool {
            switch self {
            case .picker, .datePicker: return true
            default: return false
            }
        }
    }
}

@propertyWrapper
public class FormFieldTitle {
    private var value: String = ""
    var isOptional: Bool
    
    public var wrappedValue: String {
        get { value }
        set {
            if !newValue.isEmpty {
                value = isOptional ? String(format: "%@ %@", newValue, "(Optional)") : newValue
            }
        }
    }
    
    public var projectedValue: FormFieldTitle { self }
    
    public init(wrappedValue: String, isOptional: Bool = false) {
        self.isOptional = isOptional
        self.wrappedValue = wrappedValue
    }
    
    func update(_ isOptional: Bool) {
        self.isOptional = isOptional
        self.wrappedValue = value
    }
}
