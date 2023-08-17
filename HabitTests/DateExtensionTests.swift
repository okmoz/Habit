//
//  DateExtensionTests.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 15.08.2023.
//

import XCTest
@testable import Habit


final class DateExtensionTests: XCTestCase {
    // MARK: isInSameDay(as:)
    
    func testIsInSameDay() {
        let date1 = Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15))!
        let date2 = Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15, hour: 12))!
        XCTAssertTrue(date1.isInSameDay(as: date2), "Dates should be in the same day.")
    }
    
    // MARK: todayMinusDaysAgo(daysAgo:)
    
    func testTodayMinusDaysAgo() {
        let daysAgo = 5 // Number of days ago
        let todayMinusDaysAgo = Date.todayMinusDaysAgo(daysAgo: daysAgo)
        let expectedDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date())!
        
        XCTAssertTrue(Calendar.current.isDate(todayMinusDaysAgo, equalTo: expectedDate, toGranularity: .day), "Today minus \(daysAgo) days should match the expected date.")
    }
    
    // MARK: isWithinLastDays(daysAgo:)
    
    func testIsWithinLastDays() {
        let threeDaysAgo = Date.todayMinusDaysAgo(daysAgo: 3)
        XCTAssertTrue(threeDaysAgo.isWithinLastDays(daysAgo: 5), "3 days ago should be within last 5 days.")
        
        let fiveDaysAgo = Date.todayMinusDaysAgo(daysAgo: 5)
        XCTAssertTrue(fiveDaysAgo.isWithinLastDays(daysAgo: 5), "5 days ago should be within last 5 days.")
        
        let today = Date.now
        XCTAssertTrue(today.isWithinLastDays(daysAgo: 5), "Today should be within last 5 days.")
        
        let threeDaysIntoFuture = Date.todayMinusDaysAgo(daysAgo: -3)
        XCTAssertFalse(threeDaysIntoFuture.isWithinLastDays(daysAgo: 5), "3 days into the future should not be within last 5 days.")
    }
    
    // MARK: days(from:)
    
    func testDaysFrom() {
        let currentDate = Date()
        let pastDate = Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!
        let daysDifference = currentDate.days(from: pastDate)
        
        XCTAssertEqual(daysDifference, 3, "Days difference should be 3.")
    }
    
    // MARK: next(_:considerToday:)
    
    func testNextWeekday() {
        let calendar = Calendar(identifier: .gregorian)
        let baseDate = calendar.date(from: DateComponents(year: 2023, month: 8, day: 15))!
        let nextTuesday = baseDate.next(.tuesday)
        let nextTuesdayComponents = calendar.dateComponents([.weekday], from: nextTuesday)
        XCTAssertEqual(nextTuesdayComponents.weekday, 3, "Next Tuesday's weekday value should be 3.")
    }
    
    // MARK: previous(_:considerToday:)
    
    func testPreviousWeekday() {
        let calendar = Calendar(identifier: .gregorian)
        let baseDate = calendar.date(from: DateComponents(year: 2023, month: 8, day: 15))!
        let previousFriday = baseDate.previous(.friday)
        let previousFridayComponents = calendar.dateComponents([.weekday], from: previousFriday)
        XCTAssertEqual(previousFridayComponents.weekday, 6, "Previous Friday's weekday value should be 6.")
    }
    
    // MARK: asDateComponents
    
    func testAsDateComponents() {
        let dates = [
            Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15, hour: 10))!,
            Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 16, hour: 15))!
        ]
        let dateComponents = dates.asDateComponents
        XCTAssertEqual(dateComponents.count, 2, "Date components count should be 2.")
        XCTAssertEqual(dateComponents[0].hour, 10, "First date's hour component should be 10.")
        XCTAssertEqual(dateComponents[1].hour, 15, "Second date's hour component should be 15.")
    }
    
    // MARK: asDates
    
    func testAsDates() {
        let dateComponents = [
            DateComponents(year: 2023, month: 8, day: 15, hour: 10),
            DateComponents(year: 2023, month: 8, day: 16, hour: 15)
        ]
        let dates = dateComponents.asDates
        XCTAssertEqual(dates.count, 2, "Dates count should be 2.")
        XCTAssertEqual(Calendar.current.component(.hour, from: dates[0]), 10, "First date's hour component should be 10.")
        XCTAssertEqual(Calendar.current.component(.hour, from: dates[1]), 15, "Second date's hour component should be 15.")
    }
}
