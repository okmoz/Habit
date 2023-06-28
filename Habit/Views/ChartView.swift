//
//  ChartView.swift
//  Habit
//
//  Created by Nazarii Zomko on 25.06.2023.
//

import SwiftUI

struct ChartView: View {
    var dates: [Date]
    var color: HabitColor?

    var rows: Int
    var columns: Int
    var spacing: CGFloat
    
    private var numberOfDaysToShiftBy = 0
    
    init(dates: [Date], color: HabitColor? = nil, columns: Int = 20, spacing: CGFloat = 3) {
        self.dates = dates
        self.color = color
        self.rows = 7
        self.columns = columns
        self.spacing = spacing
        
        self.numberOfDaysToShiftBy = getNumberOfDaysToShiftBy()
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<columns, id: \.self) { column in
                VStack(spacing: spacing) {
                    ForEach(0..<rows, id: \.self) { row in
                        let number = getNumberForCell(column: column, row: row)
                        let color = getColorForCell(number: number)
                        
                        RoundedRectangle(cornerRadius: 3)
                            .strokeBorder(.gray.opacity(0), lineWidth: 0.08) // TODO: fix stroke on emty cells
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(color)
                            )
                            .aspectRatio(1.0, contentMode: .fit)
                            .overlay {
//                                Text("\(getDayOfMonth(daysAgo: number))")
//                                    .font(.system(size: 6))
//                                Text("\(number)")
//                                    .font(.system(size: 10))
                            }
                    }
                }
            }
        }
    }
    
    func getColorForCell(number: Int) -> Color {
        let date = getDateForCell(numberOfDaysAgo: number)
        
        if isDayAfterToday(date: date) {
            return .clear
        } else {
            let isDateChecked = isDateChecked(date)
            return isDateChecked ? Color(color ?? .green) : .gray.opacity(0.1)
        }
    }
    
    func isDayAfterToday(date: Date) -> Bool {
        let result = Calendar.current.compare(Date.now, to: date, toGranularity: .day)
        return result == .orderedAscending ? true : false
    }
    
    func getDateForCell(numberOfDaysAgo: Int) -> Date {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -numberOfDaysAgo, to: today)!
        return todayMinusDaysAgo
    }
    
    /// Returns the delta of days between sunday and today.
    func getNumberOfDaysToShiftBy() -> Int {
        let today = Date.today()
        let nextSunday = today.next(.sunday)
        
        return nextSunday.days(from: today)
    }
    
    /// Reverses the numbers from left to right so that number '0' now starts at the bottom right instead of top left. It also shifts all numbers so that the first row of cells will always begin on Sunday.
    func getNumberForCell(column: Int, row: Int) -> Int {
        let number = (rows * column) + row
        let cellCount = columns * rows
        let reverseNumber = abs(number - cellCount) - 1
        let reverseNumberShifted = reverseNumber - numberOfDaysToShiftBy
        return reverseNumberShifted
    }
    
    func getDayOfMonth(daysAgo: Int) -> String {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d"
        let dayNumber = dateFormatter.string(from: todayMinusDaysAgo)
        
        return dayNumber
    }
    
    // TODO: make functional?
    func isDateChecked(_ habitDate: Date) -> Bool {
        for date in dates {
            if Calendar.current.isDate(date, inSameDayAs: habitDate) {
                return true
            }
        }
        return false
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let habit = Habit.example
        ChartView(dates: habit.checkedDates, color: habit.color)
    }
}
