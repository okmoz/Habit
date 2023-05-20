#  Notes
    
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

// I don't think init is the right place to set @State variables. This is how Paul does it. But a better way would be to set these variables in .onAppear; It feels more Swifty.
//    init(habit: Habit) {
//        self.habit = habit
//
//        _title = State(wrappedValue: habit.title)
//        _motivation = State(wrappedValue: habit.motivation)
//        _color = State(wrappedValue: habit.color)
//    }
