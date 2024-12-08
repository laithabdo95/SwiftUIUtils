//
//  FormToggleView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 06/09/2024.
//

import SwiftUI

struct FormToggleView<ViewModel: FormToggleConfigurable>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Toggle(isOn: $viewModel.isOn) {
            Text(viewModel.label)
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
    }
}

#Preview {
    FormToggleView(
        viewModel: FormToggleViewModel(isOn: true, label: "Any Label")
    )
}
