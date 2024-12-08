//
//  ConfirmationRowView.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 21/09/2024.
//

import SwiftUI
import UIKit

struct ConfirmationRowView<ViewModel: ConfirmationRowViewConfigurable>: View {
    
    // MARK: Properties
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: Body
    
    var body: some View {
        switch viewModel.orientation {
        case .vertical:
            VerticalView
        case .horizontal:
            HorizontalView
        }
    }
}

// MARK: - SubViews
private extension ConfirmationRowView {
    
    var keyLabel: some View {
        Text(viewModel.item.key)
            .font(ConfirmationSetting.RowView.keyTextFont)
            .foregroundStyle(ConfirmationSetting.RowView.keyTextForgroundColor)
    }
    
    var valueLabel: some View {
        Text(viewModel.item.value)
            .font(ConfirmationSetting.RowView.valueTextFont)
            .foregroundStyle(ConfirmationSetting.RowView.valueTextForgroundColor)
    }
    
    var VerticalView: some View {
        VStack(alignment: .leading) {
            keyLabel
            HStack {
                valueLabel
                Spacer()
                if let image = viewModel.image {
                    ButtonView(image: image) {
                        viewModel.onTapHandler?()
                    }
                }
            }
            .frame(height: 10)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    var HorizontalView: some View {
        HStack {
            keyLabel
            Spacer()
            valueLabel
        }
    }
}

#Preview {
    ConfirmationRowView(
        viewModel: ConfirmationRowViewModel(
            item: .init(
                key: "Name",
                value: "Majd"
            ),
            orientation: .vertical(UIImage(systemName: "calendar"))
        )
    )
}
