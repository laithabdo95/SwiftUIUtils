//
//  TemplateView.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 21/09/2024.
//

import SwiftUI

struct TemplateView: View {
    
    @State private var fruits = [
        "Apple",
        "Banana",
        "Papaya",
        "Mango"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit)
                    }
                    .onDelete { fruits.remove(atOffsets: $0) }
                    .onMove { fruits.move(fromOffsets: $0, toOffset: $1) }
                }
                .navigationTitle("Fruits")
                .toolbar {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    TemplateView()
}
