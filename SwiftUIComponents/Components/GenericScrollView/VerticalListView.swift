//
//  VerticalListView.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawoud on 29/08/2024.
//

import SwiftUI

struct VerticalListView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack {
                content
            }
        }
        .padding(.horizontal, FormSetting.VerticalList.padding)
    }
}
