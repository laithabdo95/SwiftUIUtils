//
//  ButtonView.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 07/10/2024.
//

import SwiftUI
import UIKit

public struct ButtonView: View {
    @State var image: UIImage
    var onTapHandler: (() -> Void)
    
    public var body: some View {
        Button(action: {
            onTapHandler()
        }, label: {
            Image(uiImage: image)
        })
    }
}
