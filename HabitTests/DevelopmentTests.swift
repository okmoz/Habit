//
//  DevelopmentTests.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 26.05.2023.
//

import CoreData
import XCTest
@testable import Habit

final class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        
        XCTAssertEqual(try managedObjectContext.count(for: Habit.fetchRequest()), 10, "There should be 10 sample habits.")
    }
    
    func testDeleteClearsEverything() throws {
        try dataController.createSampleData()
        dataController.deleteAll()
        
        XCTAssertEqual(try managedObjectContext.count(for: Habit.fetchRequest()), 0, "deleteAll() should leave 0 items.")
    }
    
    func testExampleHabitHasTitle() {
        let habit = Habit.example
        XCTAssertFalse(habit.title.isEmpty)
    }
    
    func testExampleHabitHasCompletedDates() {
        let habit = Habit.example
        XCTAssertFalse(habit.completedDates.isEmpty)
    }
}
