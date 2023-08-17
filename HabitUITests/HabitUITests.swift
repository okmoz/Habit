//
//  HabitUITests.swift
//  HabitUITests
//
//  Created by Nazarii Zomko on 29.05.2023.
//

import XCTest

// TODO: Do not include UI tests because they are riddled with bugs. Also they are slow to run. It even crashes Xcode sometimes lol
final class HabitUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    func testAddingAndDeletingHabit() {
        let habitText = app.staticTexts["Habit"]
        XCTAssert(habitText.exists, "There should be a 'Habit' text above the list in the HeaderView.")
        
        app.buttons["addHabit"].tap()
        let nameTextField = app.textFields["nameTextField"]
        nameTextField.tap()
        nameTextField.typeText("test")
        app.buttons["saveHabit"].tap()
        XCTAssertTrue(app.staticTexts["test"].exists, "There should be 1 habit in list with a title 'test'.")
        
        app.staticTexts["test"].tap()
        app.buttons["editHabit"].tap()
        app.buttons["deleteHabit"].tap()
        XCTAssertFalse(app.staticTexts["test_habit_name"].exists, "There should be 0 habits in list.")
    }
}
