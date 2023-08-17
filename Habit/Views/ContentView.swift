//
//  ContentView.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentingEditHabitView = false
    @AppStorage("sortingOption") private var sortingOption: SortingOption = .byDate
    @AppStorage("isSortingOrderDescending") private var isSortingOrderAscending = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                HeaderView()
                HabitListView(sortingOption: sortingOption, isSortingOrderAscending: isSortingOrderAscending)
            }
            .toolbar {
                addHabitToolbarItem
                sortMenuToolbarItem
            }
            .sheet(isPresented: $isPresentingEditHabitView) {
                EditHabitView(habit: nil)
            }
        }
    }
    
    var addHabitToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                isPresentingEditHabitView = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 19).weight(.light))
                    .tint(.primary)
            }
            .accessibilityLabel("Add Habit")
            .accessibilityIdentifier("addHabit")
        }
    }
    
    var sortMenuToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            SortMenuView(selectedSortingOption: $sortingOption, isSortingOrderAscending: $isSortingOrderAscending)
                .tint(.primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
            .environment(\.locale, .init(identifier: "uk"))
        
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
