//
//  HabitColor.swift
//  Habit
//
//  Created by Nazarii Zomko on 22.05.2023.
//

import SwiftUI

/// Represents the color options for a habit.
enum HabitColor: String, CaseIterable, Identifiable {
    /// The unique identifier of the color.
    var id: Self { self }
    
    case yellow
    case purple
    case cyan
    case pink
    case red
    case orange
    case jasmine
    case green
    case blue
    
    /// Returns a random `HabitColor`.
    static var randomColor: HabitColor {
        HabitColor.allCases.randomElement() ?? .blue
    }
}

extension Color {
    /// Initializes a SwiftUI `Color` instance with a custom `HabitColor`.
    ///
    /// This convenience initializer allows you to initialize a SwiftUI `Color` instance using a `HabitColor`. It internally uses the raw value of the `HabitColor` enum as the initializer parameter for `Color`.
    ///
    /// - Parameter customColor: The custom `HabitColor` to use for creating the `Color`.
    ///
    /// - Example:
    /// ```
    /// let habitColor = HabitColor.yellow
    /// let color = Color(habitColor)
    /// ```
    init(_ customColor: HabitColor) {
        self.init(customColor.rawValue)
    }
}
