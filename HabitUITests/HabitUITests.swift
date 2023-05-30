//
//  HabitUITests.swift
//  HabitUITests
//
//  Created by Nazarii Zomko on 29.05.2023.
//

import XCTest

// TODO: Do not include UI tests because they are riddled with bugs. Also they are slow to run. It even crashes Xcode sometimes lol
final class HabitUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"] // N: This does not mean anything, we just created it ourselves to use it later in DataController for debug mode.
        app.launchArguments = ["-AppleLanguages", "(en-US)"] // Set English localization
        app.launch()
    }

    func testAppHasZeroTabs() throws {
        // TODO: I should probably remove this because it is useless.
        XCTAssertEqual(app.tabBars.buttons.count, 0, "There should be 0 tabs in the app.")
    }
}
