//
//  ConfirmationListView.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 21/09/2024.
//

import SwiftUI

public struct ConfirmationListView<ViewModel: ConfirmationListViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    public var body: some View {
        VStack {
            ScrollView {
                SectionViews
            }
            FormButtonView(
                title: ConfirmationSetting.ListView.actionButtonTitle,
                buttonColor: ConfirmationSetting.ListView.actionButtonColor,
                titleColor: ConfirmationSetting.ListView.actionButtonTitleColor,
                cornerRadius: ConfirmationSetting.ListView.actionButtonCornerRadius
            ) {
                dismiss()
            }
                .padding()
        }
        .background(ConfirmationSetting.ListView.backgroundColor)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

// MARK: - SubViews

private extension ConfirmationListView {
    var SectionViews: some View {
        VStack {
            ForEach(viewModel.sections) { section in
                VStack(alignment: .leading, spacing: 0) {
                    Text(section.title)
                        .foregroundColor(ConfirmationSetting.SectionHeader.foregroundColor)
                        .padding([.leading, .bottom], 10)
                    
                    VStack(spacing: 20){
                        ForEach(section.items) { item in
                            ConfirmationRowView(viewModel: item)
                        }
                    }
                    .padding(25)
                    .background(ConfirmationSetting.ListView.rowsBackgroundColor)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
                }
            }
            .padding()
        }
    }
}
