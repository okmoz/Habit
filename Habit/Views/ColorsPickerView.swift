//
//  ColorsPickerView.swift
//  Habit
//
//  Created by Nazarii Zomko on 18.05.2023.
//

import SwiftUI

struct ColorsPickerView: View {
    let colors = HabitColor.allCases
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedColor: HabitColor
    
    let gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout) {
            ForEach(colors) { color in
                GeometryReader { geo in
                    Circle()
                        .foregroundColor(Color(color))
                        .overlay {
                            if selectedColor == color {
                                Image("checkmark")
                                    .resizable()
                                    .frame(width: geo.size.width / 6, height: geo.size.height / 6)
                                    .padding()
                            }
                        }
                        .onTapGesture {
                            self.selectedColor = color
                            HapticController.shared.impact(style: .rigid)
                            dismiss()
                        }
                }
                .aspectRatio(1, contentMode: .fit)
                //                .background(.pink)
            }
        }
        .padding()
        //        .border(.cyan)
    }
}

struct ColorsPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorsPickerView(selectedColor: .constant(.blue))
            .previewLayout(.sizeThatFits)
        
        ColorsPickerView(selectedColor: .constant(.blue))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}
