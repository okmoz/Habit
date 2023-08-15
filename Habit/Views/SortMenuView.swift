//
//  SortMenuView.swift
//  Habit
//
//  Created by Nazarii Zomko on 19.07.2023.
//

import SwiftUI

enum SortingOption: String, CaseIterable, Identifiable {
    var id: Self { self }
    case byDate = "Sort by Date"
    case byName = "Sort by Name"
    
    func localizedString() -> LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}

struct SortMenuView: View {
    @Binding var selectedSortingOption: SortingOption
    @Binding var isSortingOrderAscending: Bool
    
    // Item selection in Picker is handled internally, so we need a custom binding that will handle the "willSet" case when the selection has changed. This way, we will have access to the old value of the binding before it gets replaced with a new one.
    var sorting: Binding<SortingOption> {
        .init(
            get: { self.selectedSortingOption },
            set: { newValue in
                withAnimation {
                    if self.selectedSortingOption == newValue {
                        self.isSortingOrderAscending.toggle()
                        self.selectedSortingOption = newValue
                    } else {
                        self.isSortingOrderAscending = false
                        self.selectedSortingOption = newValue
                    }
                }
            }
        )
    }
    
    var body: some View {
        Menu {
            Picker("Sorting", selection: sorting) {
                ForEach(SortingOption.allCases) { sortingOption in
                    HStack {
                        Text(sortingOption.localizedString())
                        if selectedSortingOption == sortingOption {
                            Image(systemName: isSortingOrderAscending ? "chevron.up" : "chevron.down")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle") // line.3.horizontal.decrease.circle / ellipsis.circle
        }
    }
}

struct OptionsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SortMenuView(selectedSortingOption: .constant(.byDate), isSortingOrderAscending: .constant(false))
    }
}
