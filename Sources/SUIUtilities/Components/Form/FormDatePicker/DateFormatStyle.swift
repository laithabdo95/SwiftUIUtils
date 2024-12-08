//
//  DateFormatStyle.swift
//  SwiftUIComponents
//
//  Created by Laith Abdo on 07/09/2024.
//

import Foundation

public enum DateFormatStyle {
    // Standard DateFormatter styles
    case full
    case long
    case medium
    case short
    
    // Custom date format cases
    case time // "HH:mm"
    case dateTime // "yyyy-MM-dd HH:mm"
    case monthDayYear // "MM/dd/yyyy"
    case dayMonthYear // "dd/MM/yyyy"
    case yearMonthDay // "yyyy/MM/dd"
    case monthDay // "MM/dd"
    case custom(String) // Allows a fully custom date format
    
    // Function to format a Date based on the case
    public func format(date: Date) -> String {
        let formatter = DateFormatter()
        
        switch self {
        case .full:
            formatter.dateStyle = .full
        case .long:
            formatter.dateStyle = .long
        case .medium:
            formatter.dateStyle = .medium
        case .short:
            formatter.dateStyle = .short
        case .time:
            formatter.dateFormat = "HH:mm"
        case .dateTime:
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
        case .monthDayYear:
            formatter.dateFormat = "MM/dd/yyyy"
        case .dayMonthYear:
            formatter.dateFormat = "dd/MM/yyyy"
        case .yearMonthDay:
            formatter.dateFormat = "yyyy/MM/dd"
        case .monthDay:
            formatter.dateFormat = "MM/dd"
        case .custom(let format):
            formatter.dateFormat = format
        }
        
        return formatter.string(from: date)
    }
}
