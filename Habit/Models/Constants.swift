//
//  Constants.swift
//  Habit
//
//  Created by Nazarii Zomko on 15.05.2023.
//

import Foundation

enum Constants {
    static let colors = [
        "Yellow",
        "Purple",
        "Cyan",
        "Pink",
        "Red",
        "Orange",
        "Jasmine",
        "Green",
        "Blue"
    ]
    
    static let motivationPrompts = [
         "Keep it Up! 🙌",
         "🙏 Feel the force of the Habit",
         "❤️ You are amazing!",
         "Let's do this!",
         "Just start 😉",
         "Yes, you can! 💪"
    ]
    
    static var randomColor: String {
        Self.colors.randomElement() ?? "Blue"
    }
    
    static let dayOfTheWeekFrameSize: CGFloat = 32
}
