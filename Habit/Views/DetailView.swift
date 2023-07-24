//
//  DetailView.swift
//  Habit
//
//  Created by Nazarii Zomko on 21.07.2023.
//

import SwiftUI

// TODO: confirmation before changing completed dates

struct DetailView: View {
    @ObservedObject var habit: Habit
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    
    private var completedDates: Binding<[DateComponents]> {
        Binding(
            get: { habit.completedDates.asDateComponents },
            set: { newValue in
                habit.completedDates = newValue.asDates
                dataController.save()
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                regularityAndReminder
                // Carousel like me+
                overview
                ChartView(dates: habit.completedDates, color: habit.color)
                    .padding()
            }
            .navigationTitle("\(habit.title)")
            .toolbarBackground(Color(habit.color), for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    NavigationLink("Edit") {
                        EditHabitView(habit: habit)
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
    
    var regularityAndReminder: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("REGULARITY")
                    .font(.caption.bold())
                Text("every day")
            }
            .padding(.leading)
            .padding(.trailing, 70)
            
            VStack(alignment: .leading) {
                Text("REMIND ME")
                    .font(.caption.bold())
                Text("--:--")
            }
            Spacer()
        }
        .foregroundColor(.black)
        .padding(.top, 40)
        .padding(.bottom, 15)
        .background(alignment: .bottom, content: {
            Color(habit.color)
                .frame(height: 500)
        })
    }
    
    var overview: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("OVERVIEW")
                        .font(.caption.bold())
                    Text("\(habit.completionPercentage)%")
                        .font(.system(size: 50).bold())
                }
                HStack {
                    Text("Month +2%")
                        .padding(.trailing, 60)
                    Text("Year +99%")
                }
            }
            .foregroundColor(.primary)

            Spacer()
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habit: Habit.example)
            .previewLayout(.sizeThatFits)
    }
}


