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
