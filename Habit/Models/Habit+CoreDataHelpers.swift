//
//  Habit+CoreDataHelpers.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.05.2023.
//

import Foundation
import CoreData

// Paul Hegarty (cs193p) suggests to use "_" for attributes that should never be nil.

/// The `Habit` entity represents a habit in the application.
/// It is an `NSManagedObject` subclass that is automatically generated by Core Data based on the entity definition in the data model.
///
/// This extension provides convenience methods and computed properties for easy access and manipulation of `Habit` instances.
extension Habit {
    /// Initializes a new `Habit` instance with the given parameters.
    ///
    /// This convenience initializer allows you to create a new `Habit` instance with the specified properties, and automatically sets the creation date to the current date and the completed dates to an empty array.
    ///
    /// - Parameters:
    ///   - context: The managed object context in which the new `Habit` instance will be inserted.
    ///   - title: The title of the habit.
    ///   - motivation: The motivation or reason behind the habit.
    ///   - color: The color associated with the habit.
    convenience init(context: NSManagedObjectContext, title: String, motivation: String, color: HabitColor) {
        self.init(context: context)
        self.id = UUID()
        self.title = title
        self.motivation = motivation
        self.color = color
        self.creationDate = Date()
        self.completedDates = []
    }
    
    public var id: UUID {
        get { id_ ?? UUID() }
        set { id_ = newValue }
    }
    
    /// The title of the habit.
    ///
    /// Provides a convenient interface for accessing and setting the habit's title value. If the underlying storage property (`title_`) is `nil`, an empty string is returned when accessing the property.
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }

    /// The motivation behind the habit.
    ///
    /// Provides a convenient interface for accessing and setting the habit's motivation text. If the underlying storage property (`motivation_`) is `nil`, an empty string is returned when accessing the property.
    var motivation: String {
        get { motivation_ ?? "" }
        set { motivation_ = newValue }
    }

    /// The creation date of the habit.
    ///
    /// Provides a convenient interface for accessing and setting the habit's creation date. If the underlying storage property (`creationDate_`) is `nil`, the current date is returned when accessing the property.
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }

    /// The color of the habit.
    ///
    /// Provides a convenient interface for accessing and setting the habit's color. If the underlying storage property (`color_`) is `nil`, the default color value of `.blue` is returned when accessing the property.
    var color: HabitColor {
        get { .init(rawValue: color_ ?? "blue") ?? .blue }
        set { color_ = newValue.rawValue }
    }

    /// The dates when the habit was completed.
    ///
    /// Provides a convenient interface for accessing and setting the habit's completed dates. If the underlying storage property (`completedDates_`) is `nil`, an empty array is returned when accessing the property.
    var completedDates: [Date] {
        get { completedDates_ ?? [] }
        set { completedDates_ = newValue }
    }

    /// A preconfigured example `Habit` instance for testing or previewing purposes.
    ///
    /// - Note: This example habit is created in an in-memory managed object context and is not persisted to disk. It serves as a placeholder or template for displaying sample data.
    static var example: Habit {
        let dataController = DataController.preview
        let viewContext = dataController.container.viewContext
        
        let habit = Habit(context: viewContext, title: "Example Habit", motivation: "Motivation text", color: HabitColor.randomColor)
        habit.completedDates_ = Constants.getRandomDates(maxDaysBack: 7*26)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return habit
    }
}
