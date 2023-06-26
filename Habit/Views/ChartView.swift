//
//  ChartView.swift
//  Habit
//
//  Created by Nazarii Zomko on 25.06.2023.
//

import SwiftUI

struct ChartView: View {
    var columns = 26
    var rows = 7
    let spacing: CGFloat = 2
    
    @State private var dates: [Date] = []
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: spacing) {
                ForEach(0..<columns, id: \.self) { column in
                    VStack(spacing: spacing) {
                        ForEach(0..<rows, id: \.self) { row in
                            let number = getNumberForCell(column: column, row: row)
                            let isDateChecked = isChecked(daysAgo: number)
                            
                            RoundedRectangle(cornerRadius: 2)
                                .fill(isDateChecked ? .green : .gray.opacity(0.1))
                                .aspectRatio(1.0, contentMode: .fit)
                                .overlay {
                                    Text("\(getDayOfMonth(daysAgo: number))")
                                        .font(.system(size: 6))
//                                    Text("\(number)")
//                                        .font(.system(size: 6))
                                }
                        }
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .padding()
        .onAppear() {
            dates = getRandomDates(maxDaysBack: 180)
//            dates = [Date.now]
            print(dates)
        }
    }
    
    func getDayOfMonth(daysAgo: Int) -> String {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let dayNumber = dateFormatter.string(from: todayMinusDaysAgo)
        
        return dayNumber
    }
    
    func getNumberForCell(column: Int, row: Int) -> Int {
        // reverse the numbers from left to right so that number '1' now starts at the top right corner instead of top left;
        // original calculation for number (start at the top left): let number = (rows * column) + row
        let cellCount = columns * rows
        let maxNumberInCol = rows * column + rows
        let reversedMaxNumberInCol = abs(maxNumberInCol - cellCount) + rows
        let reversedRowNumber = abs(rows - row)
        let number = reversedMaxNumberInCol - reversedRowNumber
        return number
    }
    
    func isChecked(daysAgo: Int) -> Bool {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        for date in dates {
            if Calendar.current.isDate(date, inSameDayAs: todayMinusDaysAgo) {
                return true
            }
        }
        return false
    }
    
    func getRandomDates(maxDaysBack: Int) -> [Date] {
        var dates: [Date] = []
        let today = Date.now
        
        for daysBack in 0..<maxDaysBack {
            let shouldAddDate = Int.random(in: 1...100) <= 25 // returns true with a chance of 75%
            
            if shouldAddDate {
                let todayMinusDaysBack = Calendar.current.date(byAdding: .day, value: -daysBack, to: today)!
                dates.append(todayMinusDaysBack)
            }
        }
        return dates
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
