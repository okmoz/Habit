//
//  DataController.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.05.2023.
//

import CoreData

/// The `DataController` class is responsible for managing the Core Data stack and providing methods to interact with the data store.
///
/// It is implemented as a singleton using the static `shared` property, allowing access to the same instance across the application.
///
/// The `DataController` class provides the following functionalities:
/// - Loading the persistent stores for the Core Data stack.
/// - Saving changes made to the managed object context.
/// - Deleting objects from the managed object context.
/// - Creating a preview instance for testing and previewing purposes.
///
/// To use the `DataController`, simply access its shared instance using `DataController.shared`.
///
/// Example usage:
/// ```
/// let dataController = DataController.shared
/// dataController.save()
/// ```
class DataController: ObservableObject {
    
    /// The shared instance of the `DataController`.
    static let shared = DataController()
    
    /// The persistent container representing the Core Data stack.
    let container: NSPersistentContainer
    
    /// Initializes the `DataController` instance, either in memory (for temporary use such as testing and previewing), or on permanent storage (for use in regular app runs).
    ///
    /// - Parameter inMemory: A Boolean value indicating whether to use an in-memory database.
    ///                       Defaults to `false` which uses a persistent store on disk.
    ///
    /// - Note: When `inMemory` is `true`, a temporary, in-memory database is created. Data written to this database is destroyed after the app finishes running.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Habit")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// Saves Core Data context iff (if and only if) there are changes.
    ///
    /// This method checks if the managed object context has any changes and attempts to save them.
    /// - Note: Errors during the save operation are ignored, but this should be fine because the attributes are optional.
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    /// Deletes an object from the managed object context.
    ///
    /// - Parameter object: The `NSManagedObject` to be deleted.
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    /// The preview instance of the `DataController`.
    ///
    /// This instance is created with an in-memory database and populated with example data for testing and previewing purposes.
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return dataController
    }()
    
    
    /// Creates example habits for testing and previewing purposes.
    ///
    /// This method generates example `Habit` objects with sample data and saves them to the managed object context.
    ///
    /// - Throws: An NSError sent from calling save() on the NSManagedObjectContext.
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        for i in 0..<10 {
            let newHabit = Habit(context: viewContext)
            newHabit.title = "Habit \(i)"
            newHabit.creationDate = Date()
            newHabit.color = HabitColor.randomColor
        }
        
        try viewContext.save()
    }
}
