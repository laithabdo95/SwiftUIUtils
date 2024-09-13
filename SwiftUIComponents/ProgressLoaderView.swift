//
//  ProgressLoaderView.swift
//  CABPlatform
//
//  Created by Laith Abdo on 11/09/2024.
//

import SwiftUI

struct ProgressLoaderView: View {
    let total: Int
    @Binding var current: Int
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss
    var handler: (() -> Void)
    
    var progress: Double {
        Double(current) * numberOfSlices
    }
    
    private var numberOfSlices: Double {
        (100.0 / Double(total)) / 100
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(.mint)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.mint)
                
                VStack(spacing: 25) {
                    Text("Uploading Attachments..")
                        .font(.title3)
                        .foregroundColor(.mint)
                    
                    Text(String(format: "%@/%@", current.description, total.description))
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 300, height: 300)
            Spacer()
            if current == total {
                Button(action: {
                    handler()
                    dismiss()
                }) {
                    Text("Finalize")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(.mint)
                        .cornerRadius(15.0)
                        .padding(.top, 15)
                }
            }
        }
        .padding()
        .background(ClearBackgroundView(alpha: 0.9))
    }
}
