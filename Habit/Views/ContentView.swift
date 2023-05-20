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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.creationDate_, ascending: false)],
        animation: .none)
    private var habits: FetchedResults<Habit>
    
    @State private var isPresentingAddHabitView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                HeaderView()
                List {
                    ForEach(habits) { habit in
//                        Text(habit.title)
                        HabitRowView(habit: habit)
                    }
                    .onDelete(perform: deleteItems)
                    .listRowSeparator(.hidden)
                    .buttonStyle(.plain)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 6, trailing: 16))
                }
                .listStyle(.plain)
            }
            .sheet(isPresented: $isPresentingAddHabitView) {
                EditHabitView(habit: nil)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresentingAddHabitView = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2.weight(.light))
                            .foregroundColor(.primary)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2.weight(.light))
                }
            }
        }
    }

    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { habits[$0] }.forEach(dataController.delete(_:))
            dataController.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, DataController.preview.container.viewContext)
    }
}
