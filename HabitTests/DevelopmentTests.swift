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
    func testHabitInitialization() throws {
        let habit = Habit(context: managedObjectContext, title: "Test Habit", motivation: "Test Motivation", color: .red)
        XCTAssertNotNil(habit)
        XCTAssertEqual(habit.title, "Test Habit")
        XCTAssertEqual(habit.motivation, "Test Motivation")
        XCTAssertEqual(habit.color, HabitColor.red)
    }
    
    func testHabitExample() throws {
        let exampleHabit = Habit.example
        XCTAssertEqual(exampleHabit.title, "Example Habit")
        XCTAssertEqual(exampleHabit.motivation, "Motivation text")
        XCTAssertNotNil(exampleHabit.creationDate)
        XCTAssertNotNil(exampleHabit.color)
        XCTAssertFalse(exampleHabit.completedDates.isEmpty)
    }
    
    func testHabitPropertySet() throws {
        let habit = Habit(context: managedObjectContext, title: "Original Title", motivation: "Original Motivation", color: .green)
        
        habit.title = "New Title"
        XCTAssertEqual(habit.title, "New Title")
        
        habit.motivation = "New Motivation"
        XCTAssertEqual(habit.motivation, "New Motivation")
        
        habit.color = .yellow
        XCTAssertEqual(habit.color, .yellow)
    }
    
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        
        XCTAssertEqual(try managedObjectContext.count(for: Habit.fetchRequest()), 10, "There should be 10 sample habits.")
    }
    
    func testDeleteClearsEverything() throws {
        try dataController.createSampleData()
        dataController.deleteAll()
        
        XCTAssertEqual(try managedObjectContext.count(for: Habit.fetchRequest()), 0, "deleteAll() should leave 0 items.")
    }
}
