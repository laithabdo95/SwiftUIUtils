//
//  Coordinator.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 10/11/2024.
//

import SwiftUI

final class Coordinator: CoordinatorBuildable {
    
    @Published var path = NavigationPath()
    @Published var sheet: Destination?
    @Published var fullScreenCover: Destination?
}

extension Coordinator {
    func push<D: DestinationBuildable>(page: D) {
        path.append(Destination(page))
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet<D: DestinationBuildable>(_ sheet: D) {
        self.sheet = Destination(sheet)
    }
    
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D) {
        self.fullScreenCover = Destination(fullScreenCover)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
}

extension Coordinator {
    
    @ViewBuilder
    func build(page: Destination) -> some View {
        page.view
    }

    @ViewBuilder
    func buildSheet(sheet: Destination) -> some View {
        sheet.view
    }

    @ViewBuilder
    func buildFullScreenCover(cover: Destination) -> some View {
        cover.view
    }
}
