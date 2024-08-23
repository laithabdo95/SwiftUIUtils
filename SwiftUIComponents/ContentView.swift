//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 23/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            FormField(placeholder: "Primary Email")
            FormField(placeholder: "Mandetory Email")
            Spacer()
            Button(action: {
                
            }, label: {
                Text("Hit Me")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(12)
            })
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    ContentView()
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
