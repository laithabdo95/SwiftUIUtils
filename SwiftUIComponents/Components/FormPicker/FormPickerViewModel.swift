//
//  FormPickerViewModel.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Combine
import SwiftUI

typealias FormPickerAndFieldConfigurable = FormPickerConfigurable & FormFieldConfigurable

protocol FormPickerConfigurable {
    var isRequired: Bool { get }
    var cancellable: Set<AnyCancellable> { get set }
    var selectionViewModel: SelectionViewModel { get }
    
    func bindSelectionViewModel()
}

class FormPickerViewModel: FormFieldViewModel, FormPickerConfigurable {
    
    @Published var isRequired: Bool
    var selectionViewModel: SelectionViewModel
    
    internal var cancellable = Set<AnyCancellable>()
    
    init(
        placeholder: String,
        isDisabled: Bool = false,
        isRequired: Bool = true,
        selectionViewModel: SelectionViewModel
    ) {
        self.isRequired = isRequired
        self.selectionViewModel = selectionViewModel
        super.init(
            placeHolder: placeholder,
            isDisabled: isDisabled,
            rules: isRequired ? [.required] : []
        )
        bindSelectionViewModel()
    }
    
    internal func bindSelectionViewModel() {
        selectionViewModel.$selectedOptions
            .map { $0.joined(separator: ", ")}
            .sink { [weak self] text in
                guard let self else { return }
                self.text = text
            }
            .store(in: &cancellable)
    }
}
