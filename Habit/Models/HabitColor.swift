//
//  HabitColor.swift
//  Habit
//
//  Created by Nazarii Zomko on 22.05.2023.
//

import SwiftUI

/// Describes the available color choices for a habit. Each case corresponds to a color with the exact same name in the HabitColors assets.
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


// FIXME: move to Extensions
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

extension UIColor {
    convenience init?(_ customColor: HabitColor) {
        self.init(named: customColor.rawValue)
    }
}
