//
//  FormDatePickerView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 30/08/2024.
//

import SwiftUI

struct FormDatePickerView<ViewModel: FormDateAndFieldConfigurable>: View  {
    @State private var showDatePicker = false
    @StateObject var viewModel: ViewModel
    
    var body: some View {
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
//                .presentationBackground(Color.black.opacity(0.8))
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



struct ClearBackgroundView: UIViewRepresentable {
    let alpha: CGFloat
    
    func makeUIView(context: Context) -> UIView {
        return InnerView(with: alpha)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
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
