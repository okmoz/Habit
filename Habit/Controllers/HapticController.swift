//
//  HapticController.swift
//  Habit
//
//  Created by Nazarii Zomko on 05.08.2023.
//

import SwiftUI

class HapticController {
    static let shared = HapticController()
    
    // FIXME: these could be just static methods, no need in a singleton
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
