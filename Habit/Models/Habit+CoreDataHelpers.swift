//
//  Habit+CoreDataHelpers.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.05.2023.
//

import Foundation
import CoreData

// Paul Hegarty (cs193p) suggests to use "_" for attributes that should never be nil
extension Habit {
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var motivation: String {
        get { motivation_ ?? "" }
        set { motivation_ = newValue }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    var color: String {
        get { color_ ?? "Cyan" }
        set { color_ = newValue }
    }
    
    var checkedDates: [Date] {
        get { checkedDates_ ?? [] }
        set { checkedDates_ = newValue }
    }
    
    var percentage: Int {
        checkedDates.count * 5 // temporary
    }
    
    func addDate(_ date: Date) {
        checkedDates.append(date)
    }
    
    func removeDate(_ date: Date) {
        checkedDates.removeAll(where: { Calendar.current.isDate($0, inSameDayAs: date) } )
    }
    
    static var example: Habit {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        
        let habit = Habit(context: viewContext)
        habit.title = "Example Habit"
        habit.motivation = "Motivation text"
        habit.creationDate = Date()
        habit.color = "Green" // TODO: set random color
        habit.checkedDates = []
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return habit
    }
    
    static func createNewEmptyHabit(context: NSManagedObjectContext) -> Habit {
        let habit = Habit(context: context)
        habit.title = ""
        habit.motivation = ""
        habit.creationDate = Date()
        habit.color = Constants.randomColor
        habit.checkedDates = []

        return habit
    }
}
