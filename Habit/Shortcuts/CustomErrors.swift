//
//  CustomErrors.swift
//  Habit
//
//  Created by Nazarii Zomko on 15.07.2023.
//

import Foundation

enum Error: Swift.Error, CustomLocalizedStringResourceConvertible {
    case notFound,
         completionFailed(title: String)
    
    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .notFound: return "Habit not found"
        case .completionFailed(let title): return "An error occurred trying to complete '\(title)'"
        }
    }
}

