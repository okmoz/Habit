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
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 0) {
                    ForEach(0..<5) {number in
                        let daysAgo = abs(number - 4) // reverse order
                        Button {
                            toggleCheckmark(daysAgo: daysAgo)
                        } label: {
                            Image(isChecked(daysAgo: daysAgo) ? "checkmark" : "circle")
                                .resizable()
                                .padding(isChecked(daysAgo: daysAgo) ? 9 : 10)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: Constants.dayOfTheWeekFrameSize, height: Constants.dayOfTheWeekFrameSize)
                                .contentShape(Rectangle())
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
            Spacer()
        }
        .sheet(isPresented: $isPresentingEditHabitView) {
            EditHabitView(habit: habit)
        }
        .background(
            ZStack {
                Color("BoxColor")
                    .onTapGesture {
                        isPresentingEditHabitView = true
                    }
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            let percentage = habit.percentage
                            
                            HStack {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: CGFloat(percentage) * 6.4)) // workaround because setting size with frame does not work
                                    .background(Circle().fill(Color(habit.color))) // workaround to stroke and fill at the same time
                                    .frame(width: 30)
                                    .foregroundColor(Color(habit.color))
                                Spacer()
                            }
                            .offset(x: -6)
                                
                            HStack {
                                Text("\(percentage)%")
//                                    .frame(minWidth: 50, alignment: .leading)
                                    .font(.system(size: 11))
//                                    .border(.red)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        


                    }
                    
//                    .border(.red)
                    Spacer()
                    HStack {
                        Text(habit.title)
                            .font(.title3)
                            .padding(.horizontal)
//                            .blendMode(.difference)
                        Spacer()
                    }

                    Spacer()
                }
            }
        )
        
        .frame(height: 95)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
//        .padding(.horizontal)
//        .padding(.vertical, 2)

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
