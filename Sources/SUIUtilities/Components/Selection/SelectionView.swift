//
//  SelectionView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

struct SelectionView<ViewModel: SelectionConfigurable>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.filteredOptions, id: \.self) { option in
                    HStack {
                        Text(option)
                        Spacer()
                        if viewModel.selectedOptions.contains(option) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // Make entire row tappable
                    .onTapGesture {
                        viewModel.toggleSelection(for: option)
                    }
                }
                .listStyle(InsetGroupedListStyle()) // Style the list
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Select an Option")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SelectionView(
        viewModel: SelectionViewModel(
            items: MaritalStatusEnum.allCases,
            selectionType: .single
        )
    )
    .environmentObject(FormManager())
}
