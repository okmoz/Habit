//
//  EditHabitView.swift
//  Habit
//
//  Created by Nazarii Zomko on 15.05.2023.
//

import SwiftUI
import CoreData

struct EditHabitView: View {
    let habit: Habit?
    
    @State private var title: String = ""
    @State private var motivation: String = ""
    @State private var color: HabitColor = HabitColor.randomColor
    
    @State private var motivationPrompt = Constants.motivationPrompts.randomElement() ?? "Yes, you can! 💪"
    
    @State private var isPresentingColorsPicker = false
    
    @FocusState private var isNameTextFieldFocused
    @FocusState private var isMotivationTextFieldFocused
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    init(habit: Habit?) {
        self.habit = habit
        
        if let habit {
            _title = State(wrappedValue: habit.title)
            _motivation = State(wrappedValue: habit.motivation)
            _color = State(wrappedValue: habit.color)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                customDivider
                nameTextField
                motivationTextField
                colorPicker
                ChartView(dates: habit?.checkedDates ?? [], color: color)
                    .padding()
                Spacer()
            }
            .toolbarBackground(Color(color), for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                cancelToolbarItem
                saveToolbarItem
                if habit != nil {
                    deleteToolbarItem
                }
            }
            .navigationTitle(habit == nil ? "Add New Habit" : "Edit a Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isPresentingColorsPicker) {
            ColorsPickerView(selectedColor: $color)
        }
        .onAppear() {
            if habit == nil {
                isNameTextFieldFocused = true
            }
        }
    }
    
    var customDivider: some View {
        Rectangle()
            .frame(height: 0.1)
            .foregroundColor(.black)
    }
    
    var nameTextField: some View {
        VStack {
            HStack {
                Text("NAME")
                    .padding(.horizontal)
                    .font(.caption.bold())
                    .foregroundColor(.black)
                Spacer()
            }
            TextField("", text: $title, prompt: Text("Read a book, Meditate etc.").foregroundColor(.black.opacity(0.23)))
                .foregroundColor(.black)
                .focused($isNameTextFieldFocused)
                .padding(.horizontal)

        }
        .padding(.top, 40)
        .padding(.bottom, 15)
        .background(
            Color(color)
        )
    }
    
    var motivationTextField: some View {
        VStack {
            HStack {
                Text("MOTIVATE YOURSELF")
                    .padding(.horizontal)
                    .font(.caption.bold())
                Spacer()
            }
            .padding(.top)
            TextField("", text: $motivation, prompt: Text(motivationPrompt))
                .focused($isMotivationTextFieldFocused)
                .font(.callout)
                .padding(.horizontal)
        }
    }
    
    var colorPicker: some View {
        HStack {
            Text("Choose color")
            Spacer()
            Circle()
                .frame(height: 20)
                .foregroundColor(Color(color))
        }
        .padding()
        .onTapGesture {
            isPresentingColorsPicker = true
        }
    }
    
    var cancelToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
                dismiss()
            }
            .foregroundColor(.black)
        }
    }
    
    var saveToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") {
                save()
                dismiss()
            }
            .foregroundColor(.black)
        }
    }
    
    var deleteToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button(role: .destructive) {
                delete()
                dismiss()
            } label: {
                Text("Delete Habit")
                    .foregroundColor(.red)
            }
        }
    }
    
    func save() {
        withAnimation {
            if let habit {
                habit.title = title
                habit.motivation = motivation
                habit.color = color
            } else {
                // Initialization creates a new habit in current managedObjectContext
                let _ = Habit(context: managedObjectContext, title: title, motivation: motivation, color: color)
            }
            dataController.save()
        }
    }
    
    func delete() {
        withAnimation {
            if let habit {
                dataController.delete(habit)
                dataController.save()
            }
        }
        dismiss()
    }
}




struct HabitView_Previews: PreviewProvider {
    // For some reason CoreData doesn't create habit example in Xcode preview. DataController(inMemory) is initialized properly only on a Simulator.
    static var habit = Habit.example
    
    static var previews: some View {
        EditHabitView(habit: habit)
    }
}

