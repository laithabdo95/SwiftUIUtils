//
//  FormPickerViewModel.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 29/08/2024.
//

import Combine
import SwiftUI
import Observation

public typealias FormPickerAndFieldConfigurable = FormPickerConfigurable & FormFieldConfigurable

public protocol FormPickerConfigurable {
    associatedtype SelectionItems: ItemSelectable
    
    var isRequired: Bool { get }
    var cancellable: Set<AnyCancellable> { get set }
    var selectionViewModel: SelectionViewModel<SelectionItems> { get }
    
    func bindSelectionViewModel()
}

@Observable
public class FormPickerViewModel<SelectionItems: ItemSelectable>: FormFieldViewModel, FormPickerConfigurable {
    
    public var isRequired: Bool
    public var selectionViewModel: SelectionViewModel<SelectionItems>
    
    public var cancellable = Set<AnyCancellable>()
    
    public init(
        title: String = "",
        placeholder: String = "",
        isDisabled: Bool = false,
        isRequired: Bool = true,
        selectionViewModel: SelectionViewModel<SelectionItems>
    ) {
        self.isRequired = isRequired
        self.selectionViewModel = selectionViewModel
        super.init(
            title: title,
            placeHolder: placeholder,
            isDisabled: isDisabled,
            isEditingDisabled: true,
            rules: isRequired ? [.required] : [],
            fieldType: .picker
        )
    }
    
    public func bindSelectionViewModel() {
        selectionViewModel.$selectedOptions
            .map { $0.joined(separator: ", ")}
            .sink { [weak self] text in
                guard let self else { return }
                self.text = text
            }
            .store(in: &cancellable)
    }
}
