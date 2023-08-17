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
    
    private var motivationPrompt = Constants.motivationPrompts.randomElement() ?? "Yes, you can! 💪"
    
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
            ScrollView {
                VStack(spacing: 0) {
                    nameTextField
                    motivationTextField
                    colorPicker                    
                }
                
            }
            .toolbar {
                saveToolbarItem
                if habit != nil {
                    deleteToolbarItem
                }
            }
            .toolbarBackground(Color(color), for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
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
    
    var nameTextField: some View {
        VStack {
            HStack {
                Text("NAME")
                    .padding(.horizontal)
                    .font(.caption.bold())
                    .foregroundColor(.black)
                Spacer()
            }
            .accessibilityHidden(true)
            TextField("Name", text: $title, prompt: Text("Read a book, Meditate etc.").foregroundColor(.black.opacity(0.23)))
                .foregroundColor(.black)
                .focused($isNameTextFieldFocused)
                .padding(.horizontal)
                .accessibilityIdentifier("nameTextField")
        }
        .padding(.top, 40)
        .padding(.bottom, 15)
        .background(alignment: .bottom, content: {
            Color(color)
                .frame(height: 500)
        })
    }
    
    var motivationTextField: some View {
        VStack {
            HStack {
                Text("MOTIVATE YOURSELF")
                    .padding(.horizontal)
                    .font(.caption.bold())
                Spacer()
            }
            .accessibilityHidden(true)
            .padding(.top)
            TextField("Motivation", text: $motivation, prompt: Text(motivationPrompt))
                .focused($isMotivationTextFieldFocused)
                .font(.callout)
                .padding(.horizontal)
        }
    }
    
    var colorPicker: some View {
        HStack {
            Text("Color")
            Spacer()
            Circle()
                .frame(height: 20)
                .foregroundColor(Color(color))
        }
        .padding()
        .onTapGesture {
            isPresentingColorsPicker = true
        }
        .accessibilityHidden(true)
    }
    
    var saveToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") {
                save()
                dismiss()
            }
            .foregroundColor(.black)
            .accessibilityIdentifier("saveHabit")
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
            .accessibilityIdentifier("deleteHabit")
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
    static var previews: some View {
        EditHabitView(habit: Habit.example)
            .previewLayout(.sizeThatFits) // Apparently, without this, preview crashes -_-
    }
}

