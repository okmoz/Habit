//
//  Constants.swift
//  Habit
//
//  Created by Nazarii Zomko on 15.05.2023.
//

import SwiftUI

enum Constants {    
    static let motivationPrompts: [LocalizedStringKey] = [
         "Keep it Up! 🙌",
         "🙏 Feel the force of the Habit",
         "❤️ You are amazing!",
         "Let's do this!",
         "Just start 😉",
         "Yes, you can! 💪"
    ]
    
    /// The size of the day of the week frame.
    ///
    /// It is used to ensure that the frame size of the checkmark (HabitRowView) and the frame size of the day of the week (HeaderView) remain consistent.
    static let dayOfTheWeekFrameSize: CGFloat = 32
    
//    #warning("move")
    static func getRandomDates(maxDaysBack: Int, chanceFrom0To100: Int = 60) -> [Date] {
        var dates: [Date] = []
        let today = Date.now
        
        for daysBack in 0..<maxDaysBack {
            let shouldAddDate = Int.random(in: 1...100) <= chanceFrom0To100 // returns true with a chance of ..%
            
            if shouldAddDate {
                let todayMinusDaysBack = Calendar.current.date(byAdding: .day, value: -daysBack, to: today)!
                dates.append(todayMinusDaysBack)
            }
        }
        return dates
    }
    
    static func isDateWithinLastDays(date: Date, daysAgo: Int) -> Bool {
        let today = Date.now
        let daysAgoDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        // TODO: <=  ?
        return daysAgoDate < date
    }
}


