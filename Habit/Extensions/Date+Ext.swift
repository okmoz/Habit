//
//  Date+Ext.swift
//  Habit
//
//  Created by Nazarii Zomko on 28.06.2023.
//

import Foundation


extension Date {
    func isInSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    static func todayMinusDaysAgo(daysAgo: Int) -> Date {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        return todayMinusDaysAgo
    }
    
    func isWithinLastDays(daysAgo: Int) -> Bool {
        let daysAgoDate = Date.todayMinusDaysAgo(daysAgo: daysAgo)
        if self.isInSameDay(as: daysAgoDate) { return true }
        return self >= daysAgoDate && self <= Date.now
    }
    
    // For previewing purposes only.
    static func getRandomDates(maxDaysBack: Int, chanceFrom0To100: Int = 60) -> [Date] {
        var dates: [Date] = []
        let today = Date.now
        
        for daysBack in 0..<maxDaysBack {
            let shouldAddDate = Int.random(in: 1...100) <= chanceFrom0To100 // returns true with a chance of ..%
            
            if shouldAddDate {
                let todayMinusDaysBack = Calendar.current.date(byAdding: .day, value: -daysBack, to: today)!
                dates.append(todayMinusDaysBack)
            }
        }
        return dates
    }
}

// Source: https://stackoverflow.com/a/33397770
extension Date {
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}

extension Date {
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}


extension [Date] {
    func removingDuplicates() -> [Date] {
        var uniqueDates: [Date] = []
        var uniqueDateSet: Set<String> = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for date in self {
            let dateString = dateFormatter.string(from: date)
            if !uniqueDateSet.contains(dateString) {
                uniqueDateSet.insert(dateString)
                uniqueDates.append(date)
            }
        }

        return uniqueDates
    }
    
    var asDateComponents: [DateComponents] {
        self.map { date in
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            dateComponents.timeZone = TimeZone.current
            dateComponents.calendar = Calendar(identifier: .gregorian)
            return dateComponents
        }
    }
}

extension [DateComponents] {
    var asDates: [Date] {
        self.compactMap { dateComponents in
            dateComponents.date
        }
    }
}

extension DateComponents {
    var date: Date {
        Calendar.current.date(from: self)!
    }
    
    func isInSameDay(as dateComponents: DateComponents) -> Bool {
        Calendar.current.isDate(self.date, inSameDayAs: dateComponents.date)
    }
}


