//
//  OptionsMenuView.swift
//  Habit
//
//  Created by Nazarii Zomko on 19.07.2023.
//

import SwiftUI

enum SortingOption: String, CaseIterable, Identifiable {
    var id: Self { self }
    case byDate = "Sort by Date"
    case byName = "Sort by Name"
}

struct OptionsMenuView: View {
    @Binding var selectedSortingOption: SortingOption
    @Binding var isSortingOrderDescending: Bool
    @Binding var isHapticFeedbackOn: Bool
    
    // Item selection in Picker is handled internally, so we need a custom binding that will handle the "willSet" case when the selection has changed. This way, we will have access to the old value of the binding before it gets replaced with a new one.
    var sorting: Binding<SortingOption> {
        Binding(
            get: { self.selectedSortingOption },
            set: { newValue in
                if self.selectedSortingOption == newValue {
                    self.isSortingOrderDescending.toggle()
                }
                self.selectedSortingOption = newValue
            }
        )
    }
    
    var body: some View {
        Menu {
            Picker("Picker", selection: sorting) {
                ForEach(SortingOption.allCases) { sortingOption in
                    HStack {
                        Text(sortingOption.rawValue)
                        if selectedSortingOption == sortingOption {
                            Image(systemName: isSortingOrderDescending ? "chevron.down" : "chevron.up")
                        }
                    }
                }
            }
            Divider()
            Toggle("Haptic Feedback", isOn: $isHapticFeedbackOn)
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

struct OptionsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsMenuView(selectedSortingOption: .constant(.byDate), isSortingOrderDescending: .constant(true), isHapticFeedbackOn: .constant(true))
    }
}
