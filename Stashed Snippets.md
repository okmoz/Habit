#  Stashed Snippets

    //    var body: some View {
    //        NavigationView {
    //            List {
    //                ForEach(habits) { habit in
    //                    NavigationLink {
    //                        Text("Habit, \(habit)")
    //                    } label: {
    //                        Text(habit.title)
    //                    }
    //                }
    //                .onDelete(perform: deleteItems)
    //            }
    //            .toolbar {
    //                ToolbarItem(placement: .navigationBarTrailing) {
    //                    EditButton()
    //                }
    //                ToolbarItem {
    //                    Button(action: addItem) {
    //                        Label("Add Item", systemImage: "plus")
    //                    }
    //                }
    //            }
    //            Text("Select an item")
    //        }
    //    }

                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

// preview
// Replace this implementation with code to handle the error appropriately.
// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.


//                                .foregroundColor(.white)
//                                .blendMode(.difference)
//                                .overlay(habitTitle.blendMode(.hue))
//                                .overlay(habitTitle.foregroundColor(.white).blendMode(.overlay))
//                                .overlay(habitTitle.foregroundColor(.black).blendMode(.overlay))
////                                .overlay(habitTitle.blendMode(.plusDarker))



**Automatically generated code from HabitUITests that has been removed.**
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }



CHARTVIEW:
//                                    let reverseNumber = abs(number - itemCount) + 1
//                                    let number = (rows * column) + row + 1

        let cellCount = columns * rows
        let maxNumberInCol = rows * column + rows
        let reversedMaxNumberInCol = abs(maxNumberInCol - cellCount) + rows
        let reversedRowNumber = abs(rows - row)
        let number = reversedMaxNumberInCol - reversedRowNumber


                            .overlay {
//                                Text("\(getDayOfMonth(daysAgo: index))")
//                                    .font(.system(size: 6))
//                                Text("\(index)")
//                                    .font(.system(size: 10))
                            }



    func getDayOfMonth(daysAgo: Int) -> String {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d"
        let dayNumber = dateFormatter.string(from: todayMinusDaysAgo)
        
        return dayNumber
    }


    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }

    func difference(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    

// Source: https://www.avanderlee.com/swiftui/conditional-view-modifier/
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


HabitRowView (percentageView)
//        ZStack {
//            Circle()
//                .stroke(style: StrokeStyle(lineWidth: CGFloat(habit.strengthPercentage) * 6.4)) // workaround because setting size with frame does not work
//                // FIXME: find a way to calculate 100% that should expand the circle all the way
//                .background(Circle().fill(Color(habit.color))) // workaround to stroke and fill at the same time
//                .frame(width: 30)
//                .foregroundColor(Color(habit.color))
//            Text("\(habit.strengthPercentage)%")
//                .font(.system(size: 11))
//                .foregroundColor(.black)
//        }


EditHabitView

                    //                    ChartView(dates: habit?.completedDates ?? [], color: color)
                    //                        .padding()
                    //                    TipView(icon: Image(systemName: "wave.3.right.circle"),
                    //                            title: "Complete habits with NFC tags",
                    //                            tutorialText: "**Step 1:** Open the \"Shortcuts\" app → Automation → Press \"+\" Button → Create Personal Automation → NFC \n\n**Step 2:** Scan your NFC Tag \n\n**Step 3:** Add Action → Search for \"Complete a Habit\" shortcut → Press on the \"Habit\" field → Choose from a list of your habits \n\n**Step 4:** Press \"Next\" → Turn off \"Ask Before Running\" → Turn on \"Notify When Run\" (Optional) → Press \"Done\"")
                    //                        .padding()

Habit+Utils
//    func isCompleted(date: Date) -> Bool {
//        for completedDate in completedDates {
//            if Calendar.current.isDate(completedDate, inSameDayAs: date) {
//                return true
//            }
//        }
//        return false
//    }


Color Invert

import SwiftUI

extension Font {
    public static func system(
        size: CGFloat,
        weight: UIFont.Weight,
        width: UIFont.Width) -> Font
    {
        return Font(
            UIFont.systemFont(
                ofSize: size,
                weight: weight,
                width: width)
        )
    }
}

struct TestView: View {
    var body: some View {
        ZStack {
            Color.gray
            Rectangle()
                .fill(.blue)
                .rotationEffect(.degrees(45))
                .offset(x: 0, y: 200)
            
            ZStack {
                text.foregroundColor(.white)
                    .blendMode(.difference)
                    .overlay(text.blendMode(.hue))
                    .overlay(text.foregroundColor(.black).blendMode(.overlay))

                    .overlay(text.foregroundColor(.white).blendMode(.overlay))
                    .overlay(text.foregroundColor(.white).blendMode(.overlay))
                    .overlay(text.foregroundColor(.white).blendMode(.overlay))

//                    .overlay(text.foregroundColor(.black).blendMode(.overlay))
                    
            }
        }
    }
    var text: some View {
        Text("One place to stack all your cards")
            .font(.system(size: 18, weight: .heavy, width: .expanded))
            .bold()
            .padding(20)
            .frame(width: 390)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
