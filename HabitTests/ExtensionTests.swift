//
//  ExtensionTests.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 15.08.2023.
//

import XCTest
@testable import Habit


final class ExtensionTests: XCTestCase {
    
    // MARK: days(from:)
    
    func testDaysFrom() {
        let currentDate = Date()
        let pastDate = Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!
        let daysDifference = currentDate.days(from: pastDate)
        
        XCTAssertEqual(daysDifference, 3)
    }
    
    // MARK: next(_:considerToday:)
    
    func testNextWeekday() {
        let calendar = Calendar(identifier: .gregorian)
        let baseDate = calendar.date(from: DateComponents(year: 2023, month: 8, day: 15))!
        let nextTuesday = baseDate.next(.tuesday)
        let nextTuesdayComponents = calendar.dateComponents([.weekday], from: nextTuesday)
        XCTAssertEqual(nextTuesdayComponents.weekday, 3) // Tuesday's weekday value is 3
    }
    
    // MARK: previous(_:considerToday:)
    
    func testPreviousWeekday() {
        let calendar = Calendar(identifier: .gregorian)
        let baseDate = calendar.date(from: DateComponents(year: 2023, month: 8, day: 15))!
        let previousFriday = baseDate.previous(.friday)
        let previousFridayComponents = calendar.dateComponents([.weekday], from: previousFriday)
        XCTAssertEqual(previousFridayComponents.weekday, 6) // Tuesday's weekday value is 3
    }
    
    // MARK: isInSameDay(as:)
    
    func testIsInSameDay() {
        let date1 = Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15))!
        let date2 = Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15, hour: 12))!
        XCTAssertTrue(date1.isInSameDay(as: date2))
    }
    
    // MARK: asDateComponents
    
    func testAsDateComponents() {
        let dates = [
            Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15, hour: 10))!,
            Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 16, hour: 15))!
        ]
        let dateComponents = dates.asDateComponents
        XCTAssertEqual(dateComponents.count, 2)
        XCTAssertEqual(dateComponents[0].hour, 10)
        XCTAssertEqual(dateComponents[1].hour, 15)
    }
    
    // MARK: asDates
    
    func testAsDates() {
        let dateComponents = [
            DateComponents(year: 2023, month: 8, day: 15, hour: 10),
            DateComponents(year: 2023, month: 8, day: 16, hour: 15)
        ]
        let dates = dateComponents.asDates
        XCTAssertEqual(dates.count, 2)
        XCTAssertEqual(Calendar.current.component(.hour, from: dates[0]), 10)
        XCTAssertEqual(Calendar.current.component(.hour, from: dates[1]), 15)
    }

}
