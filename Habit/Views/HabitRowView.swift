//
//  HabitRowView.swift
//  Habit
//
//  Created by Nazarii Zomko on 15.05.2023.
//

import SwiftUI

struct HabitRowView: View {
    @ObservedObject var habit: Habit
    
    @State private var isPresentingEditHabitView = false
    
    @EnvironmentObject var dataController: DataController
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.habitBackgroundColor
                .onTapGesture {
                    isPresentingEditHabitView = true
                }
            VStack(spacing: -8) {
                HStack() {
                    percentageView
                    Spacer()
                    checkmarksView
                        .padding(.trailing, 10)
                }
                .padding(.leading, 22)
                .padding(.top, 12)
                VStack() {
                    HStack() {
                        habitTitle
                            .padding(.horizontal, 22)
                            .allowsHitTesting(false)
                        Spacer()
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
        .frame(height: 95)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .sheet(isPresented: $isPresentingEditHabitView) {
            EditHabitView(habit: habit)
        }
    }
    
    var percentageView: some View {
        Text("\(habit.percentage)%")
            .font(.system(size: 11, weight: .medium))
            .foregroundColor(.black)
            .background(
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: CGFloat(habit.percentage) * 6.4)) // workaround because setting size with frame does not work
                    // FIXME: find a way to calculate 100% that should expand the circle all the way
                    .background(Circle().fill(Color(habit.color))) // workaround to stroke and fill at the same time
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(habit.color))
                    .offset(x: -0.5)
                )
//        ZStack {
//            Circle()
//                .stroke(style: StrokeStyle(lineWidth: CGFloat(habit.percentage) * 6.4)) // workaround because setting size with frame does not work
//                // FIXME: find a way to calculate 100% that should expand the circle all the way
//                .background(Circle().fill(Color(habit.color))) // workaround to stroke and fill at the same time
//                .frame(width: 30)
//                .foregroundColor(Color(habit.color))
//            Text("\(habit.percentage)%")
//                .font(.system(size: 11))
//                .foregroundColor(.black)
//        }
    }
    
    var checkmarksView: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) {number in
                let daysAgo = abs(number - 4) // reverse order
                Button {
                    toggleCheckmark(daysAgo: daysAgo)
                } label: {
                    Image(isChecked(daysAgo: daysAgo) ? "checkmark" : "circle")
                        .resizable()
                        .foregroundColor(.primary) // For this to work, set rendering mode to Template inside Attributes Inspector for the image.
                        .padding(isChecked(daysAgo: daysAgo) ? 9 : 10)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.dayOfTheWeekFrameSize, height: Constants.dayOfTheWeekFrameSize)
                        .contentShape(Rectangle())
                }
            }
        }
    }
    
    var habitTitle: some View {
        Text(habit.title)
            .font(.custom("", size: 19, relativeTo: .title3))
            .lineLimit(2)
    }

    func toggleCheckmark(daysAgo: Int) {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!

        if isChecked(daysAgo: daysAgo) {
            habit.removeDate(todayMinusDaysAgo)
        } else {
            habit.addDate(todayMinusDaysAgo)
        }

        dataController.save()
    }
    
    func isChecked(daysAgo: Int) -> Bool {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        for checkedDate in habit.checkedDates {
            if Calendar.current.isDate(checkedDate, inSameDayAs: todayMinusDaysAgo) {
                return true
            }
        }
        return false
    } 
}

struct HabitRowView_Previews: PreviewProvider {
    static var previews: some View {
        HabitRowView(habit: Habit.example)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
