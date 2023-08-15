//
//  HeaderView.swift
//  Habit
//
//  Created by Nazarii Zomko on 19.05.2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Habit")
                .font(.largeTitle.bold())
                .padding(.leading, 8) // 12 or 8?
            Spacer()
            HStack(spacing: 0) {
                ForEach(0..<5) { number in
                    let daysAgo = abs(number - 4) // reverse order
                    let dayInfo = getDayInfo(daysAgo: daysAgo)
                    
                    VStack(spacing: 0) {
                        Text("\(dayInfo.dayNumber)")
                        Text("\(dayInfo.dayName)")
                    }
                    .frame(width: Constants.dayOfTheWeekFrameSize, height: Constants.dayOfTheWeekFrameSize)
                    .font(.system(size: 11, weight: .bold))
                    .opacity(daysAgo == 0 ? 1 : 0.5)
                }
            }
            .padding(.trailing, 10)
        }
        .padding([.top, .leading, .trailing])
        .padding(.bottom, 4)
        .accessibilityHidden(true)
    }
    
    func getDayInfo(daysAgo: Int) -> (dayNumber: String, dayName: String) {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEEEE"
        let dayName = dateFormatter.string(from: todayMinusDaysAgo)
        
        dateFormatter.dateFormat = "d"
        let dayNumber = dateFormatter.string(from: todayMinusDaysAgo)
        
        return (dayNumber: dayNumber, dayName: dayName)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
    }
}
