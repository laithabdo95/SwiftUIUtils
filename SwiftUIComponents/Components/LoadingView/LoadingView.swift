//
//  LoadingView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 07/09/2024.
//

import SwiftUI

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(LoaderSetting.color)
                    .frame(width: 50, height: 50)
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .foregroundColor(LoaderSetting.color)
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            }
            .onAppear {
                self.isAnimating = true
            }
            Text(LoaderSetting.loadingTitle)
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(LoaderSetting.color)
        }
        .presentationBackground(Color.black.opacity(0.3))
    }
}

#Preview {
    LoadingView()
}
