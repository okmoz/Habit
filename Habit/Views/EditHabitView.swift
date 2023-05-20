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
    @State private var color: String = Constants.randomColor
    
    @State private var isPresentingColorsPicker = false
    
    @FocusState private var isNameTextFieldFocused
    @FocusState private var isMotivationTextFieldFocused
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
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
                
                VStack {
                    HStack {
                        Text("MOTIVATE YOURSELF")
                            .padding(.horizontal)
                            .font(.caption.bold())
                        Spacer()
                    }
                    .padding(.top)
                    TextField("", text: $motivation, prompt: Text(Constants.motivationPrompts.randomElement() ?? "Yes, you can! 💪"))
                        .focused($isMotivationTextFieldFocused)
                        .font(.callout)
                        .padding(.horizontal)
                }
                
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
                Spacer()
            }
            
            .toolbarBackground(Color(color), for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                
                if habit != nil {
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
            }
            .navigationTitle(habit == nil ? "Add New Habit" : "Edit a Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isPresentingColorsPicker) {
            ColorsPickerView(selectedColor: $color)
        }
        .onAppear() {
            if let habit {
                title = habit.title
                motivation = habit.motivation
                color = habit.color
            } else {
                isNameTextFieldFocused = true
            }
        }
    }
    
    func save() {
        if let habit {
            habit.title = title
            habit.motivation = motivation
            habit.color = color
        } else {
            let newHabit = Habit.createNewEmptyHabit(context: managedObjectContext)
            newHabit.title = title
            newHabit.motivation = motivation
            newHabit.color = color
        }
        dataController.save()
    }
    
    func delete() {
        if let habit {
            dataController.delete(habit)
            dataController.save()
        }
        dismiss()
    }
}




struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        EditHabitView(habit: Habit.example)
    }
}

