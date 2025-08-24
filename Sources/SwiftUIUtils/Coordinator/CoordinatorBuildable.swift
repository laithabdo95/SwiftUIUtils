//
//  CoordinatorBuildable.swift
//  SwiftUIUtils
//
//  Created by Laith Abdo on 09/11/2024.
//

import SwiftUI

/// A protocol that defines navigation and presentation responsibilities for coordinators in a SwiftUI-based application.
/// Conforming types are responsible for managing a navigation path, presenting sheets and full-screen covers, handling push/pop navigation,
/// and providing views for specific navigation destinations.
///
/// ## Responsibilities
/// - Maintain navigation state using a `NavigationPath`.
/// - Present and dismiss modal sheets and full-screen covers, optionally for specific destination types.
/// - Push and pop navigation destinations, and support popping to specific destinations or the root.
/// - Build views for individual pages, sheets, and full-screen covers.
///
/// ## Associated Types
/// - `DestinationType`: The type of navigation destination conforming to `DestinationBuildable`.
/// - `PageView`: The view type for navigation stack pages.
/// - `SheetView`: The view type for modal sheets.
/// - `FullCoverView`: The view type for full-screen covers.
///
/// ## Typical Usage
/// Conform a coordinator to this protocol to centralize navigation logic and presentation responsibilities for a flow of views or features.
@MainActor
public protocol CoordinatorBuildable: ObservableObject {
    /// The navigation stack path managed by the coordinator.
    /// 
    /// This property is used by SwiftUI's `NavigationStack` to keep track of the current navigation history
    /// and stack of pushed destinations. Coordinators use this to push, pop, and reset navigation destinations
    /// within the flow they manage, ensuring the navigation state is centralized and can be observed.
    var path: NavigationPath { get set }
    
    /// The type representing navigation destinations managed by the coordinator.
    /// 
    /// Conforming types must implement the `DestinationBuildable` protocol, which defines the requirements for
    /// building and handling navigation destinations in the coordinator's flow. `DestinationType` is used for all
    /// navigation-related actions in the coordinator, including navigation stack pages, modal sheets, and full-screen covers.
    /// 
    /// - Note: Typical implementations use an enum representing all possible destinations or routes within the coordinator's scope.
    associatedtype DestinationType: DestinationBuildable
    var sheet: DestinationType? { get set }
    var fullScreenCover: DestinationType? { get set }
    
    /// - Note: entryPoint that represinting a new NavigationStack and applied when you want to present a seperated flow such as Onboarding, Loan Request which have a seperated flow
    /// - Note: if you want to dismiss sheet presented as entry point use dismissEntry()
    func presentSheet<D: DestinationBuildable>(entryPoint: D)
    func presentFullScreenCover<D: DestinationBuildable>(entryPoint: D)
    
    /// - Note: when you present sheet without entry that meaning you are keep logic on the current coordinator without initiating a new one
    /// - Note: when you want to dismiss sheet presented without entryPoint label you should use dismissSheet() - dismissFullScreenCover()
    func presentSheet<D: DestinationBuildable>(_ sheet: D)
    func presentFullScreenCover<D: DestinationBuildable>(_ fullScreenCover: D)
    
    
    /// Pushes a new navigation destination onto the navigation stack.
    ///
    /// Use this method to programmatically navigate to a new page or destination within the coordinator's managed flow.
    /// The provided destination must conform to `DestinationBuildable` and will be appended to the navigation path.
    ///
    /// - Parameter page: The destination to push onto the navigation stack. This page must conform to `DestinationBuildable` and represents the next view or feature to navigate to.
    ///
    /// Typical usage involves calling this method in response to user actions such as tapping a navigation link, button, or triggering navigation in response to business logic.
    ///
    /// Example:
    /// ```
    /// coordinator.push(MyDestination.details)
    /// ```
    func push<D: DestinationBuildable>(_ page: D)
    
    /// Example:
    /// ```
    /// coordinator.pop()
    /// coordniator.popTo(MyDestination.details)
    /// coordniator.popToRoot()
    /// ```
    func pop()
    func popTo<D: DestinationBuildable>(_ destination: D)
    func popToRoot()
    
    /// Dismisses the currently presented modal sheet, if any.
    ///
    /// Use this method to programmatically dismiss the sheet that was previously presented using `presentSheet`.
    /// This is typically called in response to user actions such as tapping a "Close" or "Cancel" button,
    /// or when the coordinator needs to dismiss the modal sheet as part of navigation or flow logic.
    ///
    /// - Note: If there is no sheet currently presented, this method has no effect.
    /// - Note: it's recommended when you are presenting a DestinationBuildable within the same Entry not when presenting a new one
    func dismissSheet()
    func dismissFullScreenCover()
    
    
    /// Dismisses the currently presented entry point, if any.
    ///
    /// Use this method to programmatically dismiss the navigation flow or modal presentation that was initiated as a separate entry point
    /// (e.g., onboarding, loan request, or any flow that started its own `NavigationStack`).
    ///
    /// This is typically called when the user completes or cancels the entry flow, or when you want to programmatically return
    ///
    func dismissEntry()
    func dismissEntries()
    
    associatedtype PageView: View
    @ViewBuilder func build(page: DestinationType) -> PageView
    
    associatedtype SheetView: View
    @ViewBuilder func buildSheet(sheet: DestinationType) -> SheetView
    
    associatedtype FullCoverView: View
    @ViewBuilder func buildFullScreenCover(cover: DestinationType) -> FullCoverView
}
