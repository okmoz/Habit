//
//  HabitUtilsTests.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 16.08.2023.
//

import XCTest
@testable import Habit

final class HabitUtilsTests: BaseTestCase {
    func testStrengthPercentage() {
        let habit = Habit(context: managedObjectContext, title: "Test Habit", motivation: "Test Motivation", color: .red)
        
        // Test when no completed dates
        habit.completedDates = []
        XCTAssertEqual(habit.strengthPercentage, 0, "Strength percentage should be 0 when no completed dates")
        
        // Test with three dates within the strength calculation period
        let date1 = Date.todayMinusDaysAgo(daysAgo: 0)
        let date2 = Date.todayMinusDaysAgo(daysAgo: 3)
        let date3 = Date.todayMinusDaysAgo(daysAgo: 28)
        habit.completedDates = [date1, date2, date3]
        XCTAssertEqual(habit.strengthPercentage, 33, "Strength percentage should be 33% with 3 completed dates")
        
        // Test if strength percentage remains the same even when adding a date beyond the period
        let date4 = Date.todayMinusDaysAgo(daysAgo: habit.strengthCalculationPeriod + 10) // 10 is an arbitrary number
        habit.completedDates.append(date4)
        XCTAssertEqual(habit.strengthPercentage, 33, "Strength percentage calculation should not take into account dates beyond strengthCalculationPeriod.")
        
        // Test result when there are two dates of the same day
        let date5 = Date.todayMinusDaysAgo(daysAgo: 3)
        habit.completedDates.append(date5)
        XCTAssertEqual(habit.strengthPercentage, 33, "Strength percentage calculation should not take into account same-day dates.")
        
        // Test with dates in the future
        let date6 = Date.todayMinusDaysAgo(daysAgo: -5)
        habit.completedDates.append(date6)
        XCTAssertEqual(habit.strengthPercentage, 33, "Strength percentage calculation should not take into account future dates.")
    }
    
    func testStreak() {
        let habit = Habit(context: managedObjectContext, title: "Test Habit", motivation: "Test Motivation", color: .red)
        
        // Test when no completed dates
        habit.completedDates = []
        XCTAssertEqual(habit.streak, 0, "Streak should be 0 when there are no completed dates.")
        
        // Test with last 3 days
        let today = Date.now
        let dayAgo = Date.todayMinusDaysAgo(daysAgo: 1)
        let twoDaysAgo = Date.todayMinusDaysAgo(daysAgo: 2)
        habit.completedDates = [today, dayAgo, twoDaysAgo]
        XCTAssertEqual(habit.streak, 3, "Streak should be 3 with the last 3 consecutive days.")
        
        // Test with duplicate dates
        habit.completedDates = [today, dayAgo, dayAgo, twoDaysAgo]
        XCTAssertEqual(habit.streak, 3, "Streak should not change with duplicate dates.")
        
        // Test with dates in the future
        let fiveDaysIntoFuture = Date.todayMinusDaysAgo(daysAgo: -5)
        habit.completedDates = [today, dayAgo, twoDaysAgo, fiveDaysIntoFuture]
        XCTAssertEqual(habit.streak, 3, "Streak should not consider dates in the future.")
        
        // Test with 2 consecutive days but not starting today
        habit.completedDates = [dayAgo, twoDaysAgo]
        XCTAssertEqual(habit.streak, 0, "Streak should be 0 when consecutive days don't include today's date.")
    }
    
    func testLongestStreak() {
        let habit = Habit(context: managedObjectContext, title: "Test Habit", motivation: "Test Motivation", color: .red)
        
        // Test when no completed dates
        habit.completedDates = []
        XCTAssertEqual(habit.longestStreak, 0, "Streak should be 0 when there are no completed dates.")
        
        // Test with last 3 days
        let today = Date.now
        let dayAgo = Date.todayMinusDaysAgo(daysAgo: 1)
        let twoDaysAgo = Date.todayMinusDaysAgo(daysAgo: 2)
        
        habit.completedDates = [today, dayAgo, twoDaysAgo]
        XCTAssertEqual(habit.longestStreak, 3, "Streak should be 3 with the last 3 consecutive days.")
        
        // Test with duplicate dates
        habit.completedDates = [today, dayAgo, dayAgo, twoDaysAgo]
        XCTAssertEqual(habit.longestStreak, 3, "Streak should not change with duplicate dates.")
        
        // Test with dates in the future
        let fiveDaysIntoFuture = Date.todayMinusDaysAgo(daysAgo: -5)
        habit.completedDates = [today, dayAgo, twoDaysAgo, fiveDaysIntoFuture]
        XCTAssertEqual(habit.longestStreak, 3, "Streak should not consider dates in the future.")
        
        // Test with 2 consecutive days but not starting today
        habit.completedDates = [dayAgo, twoDaysAgo]
        XCTAssertEqual(habit.longestStreak, 2, "Streak should be 2 because there are 2 consecutive dates.")
        
        // Test with different streaks of consecutive days
        let tenDaysAgo = Date.todayMinusDaysAgo(daysAgo: 10)
        let elevenDaysAgo = Date.todayMinusDaysAgo(daysAgo: 11)
        let twelveDaysAgo = Date.todayMinusDaysAgo(daysAgo: 12)
        let thirteenDaysAgo = Date.todayMinusDaysAgo(daysAgo: 13)
        habit.completedDates = [today, dayAgo, twoDaysAgo, tenDaysAgo, elevenDaysAgo, twelveDaysAgo, thirteenDaysAgo]
        XCTAssertEqual(habit.longestStreak, 4, "Streak should be 4 because the longer streak of days is 4.")
    }
}


