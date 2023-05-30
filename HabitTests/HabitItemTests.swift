//
//  HabitItemTests.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 26.05.2023.
//

import CoreData
import XCTest
@testable import Habit

class HabitItemTests: BaseTestCase {

    func testCreateHabits() {
        let targetCount = 10
        
        for _ in 0..<targetCount {
            let _ = Habit(context: managedObjectContext)
        }
        
        XCTAssertEqual(try? managedObjectContext.count(for: Habit.fetchRequest()), targetCount)
        
        dataController.deleteAll()
    }
    
    // Paul also tests Cascade Delete (when you delete a project, you delete all the items inside the project)
}
