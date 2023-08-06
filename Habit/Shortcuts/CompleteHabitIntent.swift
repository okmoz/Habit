//
//  CompleteHabitIntent.swift
//  Habit
//
//  Created by Nazarii Zomko on 30.06.2023.
//

import AppIntents

struct CompleteHabitIntent: AppIntent {
    static var title: LocalizedStringResource = "Complete a Habit"
    
    static var description = IntentDescription("Completes the specified habit for today.")
    
    @Parameter(title: "Habit", description: "The habit to complete for today.", requestValueDialog: IntentDialog("Which habit would you like to complete?"))
    var habit: ShortcutsHabitEntity
    
    static var parameterSummary: some ParameterSummary {
        Summary("Complete \(\.$habit)")
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let matchingHabit = try DataController.shared.findHabit(withId: habit.id)
        let today = Date.now
        matchingHabit.addCompletedDate(today)
        DataController.shared.save()
        return .result()
    }
}
