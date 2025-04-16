//
//  ConfirmationRowViewModel.swift
//  SwiftUIUtils
//
//  Created by Majd Aldawood on 22/09/2024.
//

import SwiftUI
import UIKit

public enum ConfirmationOrientation {
    case vertical(UIImage? = nil, (() -> Void)? = nil)
    case horizontal
}

public protocol ConfirmationRowViewConfigurable: ObservableObject, Identifiable {
    var id: UUID { get }
    var item: ConfirmationRowItem { get }
    var orientation: ConfirmationOrientation { get }
    var image: UIImage? { get }
    var onTapHandler: (() -> Void)? { get }
}

public final class ConfirmationRowViewModel: ConfirmationRowViewConfigurable {
    public var id: UUID = UUID()
    public var item: ConfirmationRowItem
    public var orientation: ConfirmationOrientation
    public var image: UIImage?
    public var onTapHandler: (() -> Void)?
    
    public init(
        item: ConfirmationRowItem,
        orientation: ConfirmationOrientation = .vertical()
    ) {
        self.item = item
        self.orientation = orientation
        getOrientationAttribute()
    }
}

private extension ConfirmationRowViewModel {
    func getOrientationAttribute() {
        switch orientation {
        case let .vertical(image, handler):
            self.image = image
            self.onTapHandler = handler
        case .horizontal:
            image = nil
            onTapHandler = nil
        }
    }
}
