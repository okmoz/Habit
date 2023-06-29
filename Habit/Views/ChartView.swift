//
//  ChartView.swift
//  Habit
//
//  Created by Nazarii Zomko on 25.06.2023.
//

import SwiftUI

struct ChartView: View {
    enum DisplayModes: String, Identifiable, CaseIterable {
        var id: Self { self }
        case threeMonths = "Three months"
        case sixMonths = "Six months"
        case twelveMonths = "One year"
    }
    
    var dates: [Date]
    var color: HabitColor = .green
    
    @AppStorage("displayMode") private var displayMode: DisplayModes = .sixMonths

    private var rows: Int { getNumberOfRows() }
    private var columns: Int { getNumberOfColumns() }
    private var spacing: CGFloat { getSpacing() }
    private var cornerRadius: CGFloat { getCornerRadius() }
    private var strokeWidth: CGFloat { getStrokeWidth() }
    
    var body: some View {
        VStack {
            HStack {
                Picker("Display mode", selection: $displayMode) {
                    ForEach(DisplayModes.allCases) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            HStack(spacing: spacing) {
                ForEach(0..<columns, id: \.self) { column in
                    VStack(spacing: spacing) {
                        ForEach(0..<rows, id: \.self) { row in
                            let index = getIndexForCell(column: column, row: row)
                                                    
                            let daysShiftOffset = calculateDaysShiftOffset()
                            let shiftedIndex = index - daysShiftOffset
                            
                            let color = getColorForCell(index: shiftedIndex)
                            
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(color.fill)
//                                .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color.stroke, lineWidth: strokeWidth))
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                    }
                }
            }
    //        .drawingGroup()
        }
    }
    
    func getColorForCell(index: Int) -> (fill: Color, stroke: Color) {
        let date = getDateForCell(numberOfDaysAgo: index)
        
        if isDayAfterToday(date: date) {
            return (fill: .clear, stroke: .clear)
        } else {
            if isDateChecked(date) {
                return (fill: Color(color), stroke: .cellStrokeColor)
            } else {
                return (fill: .cellFillColor, stroke: .cellStrokeColor)
            }
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
    
    /// Returns the delta of days between sunday and today. Cells will be shifted by the offset amount so that the first row of cells will always begin on Sunday.
    func calculateDaysShiftOffset() -> Int {
        // If number of rows is less than 7 (like 7 days of the week), shifting days would not make sense because columns would not be comprised of weeks.
        guard rows == 7 else { return 0 }
        
        let today = Date.today()
        let nextSunday = today.next(.sunday)
        let offset = nextSunday.days(from: today)
        
        return offset
    }
    
    /// Reverses the numbers from left to right so that index '0' now starts at the bottom right instead of top left.
    func getIndexForCell(column: Int, row: Int) -> Int {
        let index = (rows * column) + row
        let cellCount = columns * rows
        let reverseIndex = abs(index - cellCount) - 1
        return reverseIndex
    }

    func isDateChecked(_ habitDate: Date) -> Bool {
        return dates.contains { date in
            Calendar.current.isDate(date, inSameDayAs: habitDate)
        }
    }
    
    func getNumberOfRows() -> Int {
        return displayMode == .threeMonths ? 5 : 7
    }
    
    func getNumberOfColumns() -> Int {
        switch displayMode {
        case .threeMonths:
            return Int(365/4/rows)
        case .sixMonths:
            return Int(365/2/rows)
        case .twelveMonths:
            return Int(365/rows)
        }
    }
    
    func getSpacing() -> CGFloat {
        switch displayMode {
        case .threeMonths:
            return 3
        case .sixMonths:
            return 2.5
        case .twelveMonths:
            return 1
        }
    }
    
    func getCornerRadius() -> CGFloat {
        switch displayMode {
        case .threeMonths:
            return 4
        case .sixMonths:
            return 2
        case .twelveMonths:
            return 2
        }
    }
    
    func getStrokeWidth() -> CGFloat {
        switch displayMode {
        case .threeMonths:
            return 1.2
        case .sixMonths:
            return 1
        case .twelveMonths:
            return 0.2
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let habit = Habit.example
        ChartView(dates: habit.checkedDates, color: habit.color)
    }
}
