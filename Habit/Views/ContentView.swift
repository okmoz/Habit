//
//  ContentView.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentingAddHabitView = false
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
            .sheet(isPresented: $isPresentingAddHabitView) {
                EditHabitView(habit: nil)
            }
        }
    }
    
    var addHabitToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                isPresentingAddHabitView = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 19).weight(.light))
                    .tint(.primary)
            }
            
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
        
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
