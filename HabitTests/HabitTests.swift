//
//  HabitItemTests.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 26.05.2023.
//

import CoreData
import XCTest
@testable import Habit

class HabitTests: BaseTestCase {
    func testHabitCreation() {
        let targetCount = 10
        
        for _ in 0..<targetCount {
            let _ = Habit(context: managedObjectContext)
        }
        
        XCTAssertEqual(try? managedObjectContext.count(for: Habit.fetchRequest()), targetCount)
    }
    
    func testHabitDeletionWorks() throws {
        try dataController.createSampleData()
        let habits = try self.managedObjectContext.fetch(Habit.fetchRequest())
        
        dataController.delete(habits[0])
        
        XCTAssertEqual(try managedObjectContext.count(for: Habit.fetchRequest()), 9)
    }
}
