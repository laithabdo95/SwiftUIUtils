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
    var sheet: Destination? { get set }
    var customSheet: SheetDestination? { get set}
    var fullScreenCover: DestinationType? { get set }
    
    func presentSheet<D: DestinationBuildable>(_ sheet: D, size: SheetSize)
    func presentCustomSheet<D: DestinationBuildable>(_ sheet: D, size: SheetSize)
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D)
    func push<D: DestinationBuildable>(page: D)
    
    func pop()
    func popToRoot()
    
    func dismissSheet()
    func dismissFullScreenCover()
    var sheetOnDismiss: (() -> Void)? { get set }
}
