//
//  FarmingChartContentView.swift
//
//
//  Created by 홍성준 on 12/27/23.
//

import SwiftUI
import Charts
import DesignKit

struct FarmingChartContentView: View {
    
    @EnvironmentObject var content: FarmingChartContent
    
    var body: some View {
        Chart {
            ForEach(content.groups, id: \.type) { group in
                ForEach(group.elements, id: \.date) { element in
                    LineMark(
                        x: .value("Day", element.date, unit: .day),
                        y: .value(chartValue(type: group.type), element.value)
                    )
                    .foregroundStyle(by: .value("Type", group.type.rawValue))
                    .symbol(Circle().strokeBorder(lineWidth: 2))
                }
            }
        }
        .chartForegroundStyleScale([
            FarmingChartType.ok.rawValue: Color(UIColor.csBlue5),
            FarmingChartType.pass.rawValue: Color.red
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
            }
        }
    }
    
    private func chartValue(type: FarmingChartType) -> String {
        switch type {
        case .ok: return "OK"
        case .pass: return "Pass"
        }
    }
    
}
