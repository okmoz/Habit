//
//  AssetTest.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 23.05.2023.
//

import XCTest
@testable import Habit

final class AssetTest: XCTestCase {

    func testColorsExist() {
        for color in HabitColor.allCases {
            XCTAssertNotNil(UIColor(named: color.rawValue), "Failed to load color '\(color.rawValue)' from asset catalog.")
        }
    }
    
    // TODO: Also test other assets?

    
}
