//
//  ContentView.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.05.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Habit.creationDate_, ascending: false)])
    private var habits: FetchedResults<Habit>
    
    @State private var isPresentingAddHabitView = false
    @State private var selectedSortingOption: SortingOption = .byDate
    @State private var isSortingOrderDescending = true
    @State private var isHapticFeedbackOn = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                HeaderView()
                habitList
            }
            .toolbar {
                addHabitToolbarItem
                burgerMenuToolbarItem
            }
            .sheet(isPresented: $isPresentingAddHabitView) {
                EditHabitView(habit: nil)
            }
        }
    }
    
    var habitList: some View {
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
    
    var addHabitToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                isPresentingAddHabitView = true
            } label: {
                Image(systemName: "plus")
                    .font(.title3.weight(.light))
                    .foregroundColor(.primary)
            }
            
        }
    }
    
    var burgerMenuToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Image(systemName: "calendar") // calendar / chart.xyaxis.line
                .font(.system(size: 17).weight(.light))

//            OptionsMenuView(
//                selectedSortingOption: $selectedSortingOption,
//                isSortingOrderDescending: $isSortingOrderDescending,
//                isHapticFeedbackOn: $isHapticFeedbackOn
//            )
            .foregroundColor(.primary)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.map { habits[$0] }.forEach(dataController.delete(_:))
        dataController.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
