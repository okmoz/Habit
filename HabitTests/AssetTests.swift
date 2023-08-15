//
//  AssetTest.swift
//  HabitTests
//
//  Created by Nazarii Zomko on 23.05.2023.
//

import XCTest
@testable import Habit

final class AssetTests: XCTestCase {
    func testColorsExist() {
        for color in HabitColor.allCases {
            XCTAssertNotNil(UIColor(named: color.rawValue), "Failed to load color '\(color.rawValue)' from asset catalog.")
        }
    }
    
    func testImageAssetsExist() {
        let imageNames = [
            "checkmark",
            "circle"
        ]
        
        for imageName in imageNames {
            XCTAssertNotNil(UIImage(named: imageName), "Failed to load image '\(imageName)' from asset catalog.")
        }
    }
}
