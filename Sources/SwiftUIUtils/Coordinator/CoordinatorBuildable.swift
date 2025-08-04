//
//  CoordinatorBuildable.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 09/11/2024.
//

import SwiftUI

public protocol CoordinatorBuildable: ObservableObject {
    var path: NavigationPath { get set }
    
    associatedtype DestinationType: DestinationBuildable
    var sheet: DestinationType? { get set }
    func presentSheet<D: DestinationBuildable>(entryPoint: D)
    func presentSheet<D: DestinationBuildable>(_ sheet: D)
    
    var fullScreenCover: DestinationType? { get set }
    func presentFullScreenCover<D: DestinationBuildable>(entryPoint: D)
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D)
    
    func push<D: DestinationBuildable>(page: D)
    
    func pop()
    func popToRoot()
    
    func dismissSheet()
    func dismissFullScreenCover()
    
    func dismissEntry()
    
    associatedtype PageView: View
    @ViewBuilder func build(page: DestinationType) -> PageView
    
    associatedtype SheetView: View
    @ViewBuilder func buildSheet(sheet: DestinationType) -> SheetView
    
    associatedtype FullCoverView: View
    @ViewBuilder func buildFullScreenCover(cover: DestinationType) -> FullCoverView
}
