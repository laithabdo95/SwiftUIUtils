//
//  FormDatePickerView.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

public struct FormDatePickerView<ViewModel: FormDateAndFieldConfigurable>: View  {
    @State private var showDatePicker = false
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Init
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                FormFieldView(viewModel: viewModel) {
                    showDatePicker = true
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $showDatePicker, content: {
                ZStack {
                    VStack {
                        DatePicker(
                            "Select Date",
                            selection: $viewModel.date,
                            displayedComponents: viewModel.dateType
                        )
                        .datePickerStyle(viewModel.datePickerStyle)
                        .padding()
                        .background(Color.white)
                        
                        Button("Done") {
                            showDatePicker = false
                        }
                        .padding(.vertical, 15)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(maxWidth: 300)
                }
                .background(ClearBackgroundView(alpha: 0.5))
            })
        }
    }
}

#Preview {
    FormDatePickerView(
        viewModel: FormDatePickerViewModel(
            placeHolder: "Select Birth Date",
            rules: []
        )
    )
    .environmentObject(FormManager())
}



public struct ClearBackgroundView: UIViewRepresentable {
    let alpha: CGFloat
    
    public func makeUIView(context: Context) -> UIView {
        return InnerView(with: alpha)
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    private class InnerView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .black.withAlphaComponent(alpha)
        }
        
        required init(with alpha: CGFloat) {
            super.init(frame: .zero)
            super.alpha = alpha
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}
