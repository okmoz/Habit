//
//  ShortcutsHabitEntity.swift
//  Habit
//
//  Created by Nazarii Zomko on 30.06.2023.
//

import Foundation
import AppIntents

struct ShortcutsHabitEntity: AppEntity {
    static var defaultQuery = IntentsHabitQuery()

    var id: UUID
    var title: String

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Habit")

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
        // TODO: add color of habit as image ?
    }
}

struct IntentsHabitQuery: EntityQuery {
    func entities(for identifiers: [ShortcutsHabitEntity.ID]) async throws -> [ShortcutsHabitEntity] {
        return identifiers.compactMap { id in
            if let match = try? DataController.shared.findHabit(withId: id) {
                return ShortcutsHabitEntity(id: match.id, title: match.title)
            } else {
                return nil
            }
        }
    }
    
    func suggestedEntities() async throws -> [ShortcutsHabitEntity] {
        let allHabits = DataController.shared.getAllHabits()
        return allHabits.map {
            ShortcutsHabitEntity(id: $0.id, title: $0.title)
        }
    }
}
