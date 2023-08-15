//
//  BaseTestCase.swift
//  BaseTestCase
//
//  Created by Nazarii Zomko on 23.05.2023.
//

import CoreData
import XCTest
// import all of the Habit target but make it testable and available for us to read all the classes and structs without having to mark them as public
@testable import Habit

// this will be used for all our future tests
class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        dataController = nil
        managedObjectContext = nil
    }
}
