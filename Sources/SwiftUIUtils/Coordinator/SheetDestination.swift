//
//  Coordinator.swift
//  SwiftUIUtils
//
//  Created by Qais
//
import SwiftUI

public struct SheetDestination: Identifiable {
    public let id = UUID()
    public let destination: Destination
    public let size: SheetSize
    
    public init(destination: Destination, size: SheetSize) {
        self.destination = destination
        self.size = size
    }
}

public enum SheetSize {
    case fixed(CGFloat)
    case medium
    case large
    case custom([PresentationDetent])
    
    public var detents: Set<PresentationDetent> {
        switch self {
        case .fixed(let height):
            return [.height(height)]
        case .medium:
            return [.medium]
        case .large:
            return [.large]
        case .custom(let detents):
            return Set(detents)
        }
    }
} 
