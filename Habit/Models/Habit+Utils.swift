//
//  Habit+Utils.swift
//  Habit
//
//  Created by Nazarii Zomko on 28.07.2023.
//

import Foundation

extension Habit {
    var strengthPercentage: Int {
        getStrengthPercentage(completedDates: completedDates)
    }
    
    /// The strength percentage of the habit.
    ///
    /// Represents the strength percentage of the habit based on the number of completed dates. The calculation is performed using a logarithmic formula.
    /// - Returns: An integer representing the strength percentage of the habit, ranging from 0 to 100.
    func getStrengthPercentage(completedDates: [Date]) -> Int {
        // Get completed dates within the last 70 days
        let completedDatesWithinLast70Days = completedDates.filter { Constants.isDateWithinLastDays(date: $0, daysAgo: 70) }
        
        // Calculate the strength percentage using a logarithmic formula
        let logNumber = Double(completedDatesWithinLast70Days.count + 1)
        // TODO: Calculate percentage from 0 to 1 instead of 0 to 100
        let logBase = 1.04340035560572 // With this log base, 100% will be reached in 69 days.
        let calculatedPercentage = Int(log(logNumber)/log(logBase))
        
        // Ensure the calculated percentage is within the range of 0 to 100
        return min(calculatedPercentage, 100)
    }
    
    func strengthGainedWithinLastDays(daysAgo: Int) -> Int {
        let habitStrength = getStrengthPercentage(completedDates: completedDates)
        let completedDatesWithoutLast30Days = completedDates.filter { Constants.isDateWithinLastDays(date: $0, daysAgo: daysAgo) == false }
        let habitStrengthWithoutLast30Days = getStrengthPercentage(completedDates: completedDatesWithoutLast30Days)
        let strengthGainedInMonth = habitStrength - habitStrengthWithoutLast30Days
        return strengthGainedInMonth
    }
    
    func completionsWithinLastDays(daysAgo: Int) -> Int {
        return completedDates.filter { Constants.isDateWithinLastDays(date: $0, daysAgo: daysAgo) }.count
    }
    
    var streak: Int {
        let dates = completedDates.map { Calendar.current.startOfDay(for: $0) }
        // Sort from newest to oldest
        let sortedDates = dates.sorted { $0 > $1 }
        // Check if there are any completed dates as well as get a non-optional firstDate
        guard let firstDate = sortedDates.first else { return 0 }
        // If the most recent completion date is not today, there's no current streak
        guard firstDate.isInSameDay(as: Date()) else { return 0 }
        var previousDate = firstDate
        
        var streak = 1

        for date in sortedDates.dropFirst() {
            let daysBetweenDates = previousDate.days(from: date)
            if daysBetweenDates <= 1 {
                streak += 1
            } else {
                return streak
            }
            previousDate = date
        }
        return streak
    }
    
    var longestStreak: Int {
        let dates = completedDates.map { Calendar.current.startOfDay(for: $0) }
        let sortedDates = dates.sorted { $0 > $1 }
        guard let firstDate = sortedDates.first else { return 0 }
        var previousDate = firstDate
        
        var currentStreak = 1
        var longestStreak = 0
        
        for date in sortedDates.dropFirst() {
            let daysBetweenDates = previousDate.days(from: date)
            if daysBetweenDates <= 1 {
                currentStreak += 1
            } else {
                // Check if the current streak is longer than the longest streak so far
                longestStreak = max(currentStreak, longestStreak)
                currentStreak = 1
            }
            previousDate = date
        }
        // Check if the last streak is the longest streak
        return max(currentStreak, longestStreak)

    }

    func isCompleted(daysAgo: Int) -> Bool {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        for completedDate in completedDates {
            if Calendar.current.isDate(completedDate, inSameDayAs: todayMinusDaysAgo) {
                return true
            }
        }
        return false
    }
    
    var isCompletedToday: Bool {
        return isCompleted(daysAgo: 0)
    }
}
