//
//  HabitListView.swift
//  Habit
//
//  Created by Nazarii Zomko on 30.07.2023.
//

import CoreData
import SwiftUI

struct HabitListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest var habits: FetchedResults<Habit>
    
    init(sortingOption: SortingOption, isSortingOrderAscending: Bool) {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        
        switch sortingOption {
        case .byDate:
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Habit.creationDate_, ascending: isSortingOrderAscending)]
        case .byName:
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Habit.title_, ascending: isSortingOrderAscending)]
        }
        
        _habits = FetchRequest<Habit>(fetchRequest: request)
    }
    
    var body: some View {
        List {
            ForEach(habits) { habit in
                HabitRowView(habit: habit)
            }
            .onDelete(perform: deleteItems)
            .listRowSeparator(.hidden)
            .buttonStyle(.plain)
            .listRowInsets(.init(top: 8, leading: 16, bottom: 6, trailing: 16))
        }
        .listStyle(.plain)
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.map { habits[$0] }.forEach(dataController.delete(_:))
        dataController.save()
    }
}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitListView(sortingOption: .byDate, isSortingOrderAscending: false)
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
    }
}
