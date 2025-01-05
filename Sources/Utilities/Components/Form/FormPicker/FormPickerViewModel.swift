//
//  FormPickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Combine
import SwiftUI

public typealias FormPickerAndFieldConfigurable = FormPickerConfigurable & FormFieldConfigurable

public protocol FormPickerConfigurable {
    associatedtype SelectionItems: ItemSelectable
    
    var isRequired: Bool { get }
    var cancellable: Set<AnyCancellable> { get set }
    var selectionViewModel: SelectionViewModel<SelectionItems> { get }
    
    func bindSelectionViewModel()
}

public class FormPickerViewModel<SelectionItems: ItemSelectable>: FormFieldViewModel, FormPickerConfigurable {
    
    @Published public var isRequired: Bool
    public var selectionViewModel: SelectionViewModel<SelectionItems>
    
    public var cancellable = Set<AnyCancellable>()
    
    public init(
        placeholder: String,
        isDisabled: Bool = false,
        isRequired: Bool = true,
        selectionViewModel: SelectionViewModel<SelectionItems>
    ) {
        self.isRequired = isRequired
        self.selectionViewModel = selectionViewModel
        super.init(
            placeHolder: placeholder,
            isDisabled: isDisabled,
            isEditingDisabled: true,
            rules: isRequired ? [.required] : [],
            fieldType: .picker
        )
        bindSelectionViewModel()
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
