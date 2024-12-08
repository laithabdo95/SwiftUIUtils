//
//  ConfirmationRowViewModel.swift
//  SwiftUIComponents
//
//  Created by Majd Aldawood on 22/09/2024.
//

import SwiftUI
import UIKit

enum ConfirmationOrientation {
    case vertical(UIImage? = nil, (() -> Void)? = nil)
    case horizontal
}

protocol ConfirmationRowViewConfigurable: ObservableObject, Identifiable {
    var id: UUID { get }
    var item: ConfirmationRowItem { get }
    var orientation: ConfirmationOrientation { get }
    var image: UIImage? { get }
    var onTapHandler: (() -> Void)? { get }
}

final class ConfirmationRowViewModel: ConfirmationRowViewConfigurable {
    var id: UUID = UUID()
    var item: ConfirmationRowItem
    var orientation: ConfirmationOrientation
    var image: UIImage?
    var onTapHandler: (() -> Void)?
    
    init(
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
