//
//  CoordinatorBuildable.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 09/11/2024.
//

import SwiftUI

public protocol CoordinatorBuildable: ObservableObject {
    var path: NavigationPath { get set }
    
    associatedtype Sheet: Identifiable
    var sheet: Sheet? { get set }
    func presentSheet(_ sheet: Sheet)
    
    associatedtype Cover: Identifiable
    var fullScreenCover: Cover? { get set }
    func presentFullScreenCover(_ fullScreenCover: Cover)
    
    associatedtype Page: Hashable
    func push(page: Page)
    
    func pop()
    func popToRoot()
    
    func dismissSheet()
    func dismissFullScreenCover()
    
    associatedtype PageView: View
    @ViewBuilder
    func build(page: Page) -> PageView
    
    associatedtype SheetView: View
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> SheetView
    
    associatedtype FullCoverView: View
    @ViewBuilder
    func buildFullScreenCover(cover: Cover) -> FullCoverView
}

public extension CoordinatorBuildable {
    
    func push(page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: Cover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
}
