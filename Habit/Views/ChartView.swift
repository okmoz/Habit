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
        case sixMonths = "Six months"
        case oneYear = "One year"
        
        func localizedString() -> LocalizedStringKey {
            LocalizedStringKey(self.rawValue)
        }
    }
    
    // TODO: make it a Binding
    var dates: [Date]
    var color: HabitColor = .green
    
    @AppStorage("displayMode") private var displayMode: DisplayModes = .sixMonths

    private let rows: Int = 7
    private var columns: Int { getNumberOfColumns() }
    private var spacing: CGFloat { getSpacing() }
    private var cornerRadius: CGFloat { getCornerRadius() }
    private var strokeWidth: CGFloat { getStrokeWidth() }
    
    var body: some View {
        VStack {
            HStack {
                Text("HISTORY")
                    .font(.caption.bold())
                Spacer()
                Picker("Display mode", selection: $displayMode) {
                    ForEach(DisplayModes.allCases) {
                        Text($0.localizedString())
                    }
                }
                .offset(x: 12)
                .pickerStyle(.menu)
                .tint(.secondary)
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
        .onChange(of: displayMode, perform: { _ in
            HapticController.shared.impact(style: .light)
        })
        .accessibilityHidden(true)
    }
    
    func getColorForCell(index: Int) -> (fill: Color, stroke: Color) {
        let date = getDateForCell(numberOfDaysAgo: index)
        
        // Check if day is after today and fill with clear color. If habit has been completed for the date, fill it with habit's color, otherwise fill with ligh gray color. See GitHub's contribution chart for reference of how it should look.
        if isDayAfterToday(date: date) {
            return (fill: .clear, stroke: .clear)
        } else {
            if isDateCompleted(date) {
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
        
        let today = Date.now
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

    func isDateCompleted(_ habitDate: Date) -> Bool {
        return dates.contains { date in
            date.isInSameDay(as: habitDate)
        }
    }
    
    func getNumberOfColumns() -> Int {
        switch displayMode {
        case .sixMonths:
            return Int(365/2/rows)
        case .oneYear:
            return Int(365/rows)
        }
    }
    
    func getSpacing() -> CGFloat {
        switch displayMode {
        case .sixMonths:
            return 2.5
        case .oneYear:
            return 1
        }
    }
    
    func getCornerRadius() -> CGFloat {
        switch displayMode {
        case .sixMonths:
            return 2
        case .oneYear:
            return 2
        }
    }
    
    func getStrokeWidth() -> CGFloat {
        switch displayMode {
        case .sixMonths:
            return 1
        case .oneYear:
            return 0.2
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let habit = Habit.example
        ChartView(dates: habit.completedDates, color: habit.color)
    }
}
