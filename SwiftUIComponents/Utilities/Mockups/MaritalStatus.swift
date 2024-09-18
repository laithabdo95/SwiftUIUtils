//
//  MaritalStatus.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 29/08/2024.
//

import Foundation

enum MaritalStatusEnum: String, CaseIterable {
    case single
    case married
    case divorced
}

extension MaritalStatusEnum: ItemSelectable {
    var title: String {
        self.rawValue
    }
}
