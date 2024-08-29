//
//  SelectionView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import SwiftUI

struct SelectionView<ViewModel: SelectionConfigurable>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search...", text: $viewModel.searchText)
                    .padding(10)
                    .padding(.horizontal, 15)
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
                    .padding(.horizontal)
                
                // Filtered List
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
                
                Text("Selected: \(viewModel.selectedOptions.joined(separator: ", "))")
                    .padding()
            }
            .navigationTitle("Select an Option")
        }
    }
}

#Preview {
    SelectionView(
        viewModel: SelectionViewModel(options: ["Test"])
    )
}
