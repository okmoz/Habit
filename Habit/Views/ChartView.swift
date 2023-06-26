//
//  ChartView.swift
//  Habit
//
//  Created by Nazarii Zomko on 25.06.2023.
//

import SwiftUI

struct ChartView: View {
    var columns = 10
    var rows = 5
    let spacing: CGFloat = 2
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: spacing) {
                ForEach(0..<columns, id: \.self) { column in
                    VStack(spacing: spacing) {
                        ForEach(0..<rows, id: \.self) { row in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(.green)
                                .aspectRatio(1.0, contentMode: .fit)
                                .overlay {
                                    // reverse the numbers from left to right so that number '1' now starts at the top right corner instead of top left; original number: let number = (rows * column) + row + 1
                                    let cellCount = columns * rows
                                    let maxNumberInCol = rows * column + rows
                                    let reversedMaxNumberInCol = abs(maxNumberInCol - cellCount) + rows
                                    let reversedRowNumber = abs(rows - row)
                                    let number = reversedMaxNumberInCol - reversedRowNumber
                                    Text("\(number)")
                                }
                        }
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .padding()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
