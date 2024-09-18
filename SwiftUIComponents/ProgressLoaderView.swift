//
//  ProgressLoaderView.swift
//  CABPlatform
//
//  Created by Laith Abdo on 11/09/2024.
//

import SwiftUI

protocol ProgressLoaderConfigurable: ObservableObject {
    var message: String { get }
    var current: Int { get }
    var total: Int { get }
    var hasFinished: Bool { get }
    var progress: Double { get }
    var buttonTitle: String { get }
    
    associatedtype Item
    var items: [Item] { get }
    var handler: (() -> Void) { get }
    var color: Color { get }
    var numberOfSlices: Double { get }
    
    func execute()
    
    init(items: [Item], handler: @escaping () -> Void)
}

extension ProgressLoaderConfigurable {
    var numberOfSlices: Double {
        (100.0 / Double(total)) / 100
    }
    
    var progress: Double {
        Double(current) * numberOfSlices
    }
}

struct ProgressLoaderView<ViewModel: ProgressLoaderConfigurable>: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(viewModel.color)
                
                Circle()
                    .trim(from: 0.0, to: viewModel.progress)
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    .foregroundColor(viewModel.color)
                
                VStack(spacing: 25) {
                    Text(viewModel.message)
                        .font(.title3)
                        .foregroundColor(viewModel.color)
                    
                    Text(String(format: "%@/%@", viewModel.current.description, viewModel.total.description))
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 300, height: 300)
            Spacer()
            if viewModel.hasFinished {
                Button(action: {
                    viewModel.handler()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(viewModel.buttonTitle)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(viewModel.color)
                        .cornerRadius(15.0)
                        .padding(.top, 15)
                }
            }
        }
        .onAppear {
            viewModel.execute()
        }
        .padding()
        .background(ClearBackgroundView(alpha: 0.9))
    }
}
