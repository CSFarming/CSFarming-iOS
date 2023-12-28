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
    
    @EnvironmentObject var viewModel: FarmingChartViewModel
    @Binding var rawSelectedDate: Date?
    
    var body: some View {
        Chart {
            ForEach(viewModel.content.groups, id: \.type) { group in
                ForEach(group.elements, id: \.date) { element in
                    LineMark(
                        x: .value("Day", element.date, unit: .day),
                        y: .value(chartValue(type: group.type), element.value)
                    )
                    .foregroundStyle(by: .value("Type", group.type.rawValue))
                    .symbol(Circle().strokeBorder(lineWidth: 2))
                }
            }
            
            if let rawSelectedDate {
                RuleMark(x: .value("Selected", rawSelectedDate, unit: .day))
                    .foregroundStyle(Color(UIColor.csGray5).opacity(0.3))
                    .zIndex(-1)
                    .annotation(
                        position: .top,
                        spacing: 10,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled
                        )
                    ) {
                        dateSelectionPopover
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
        .chartXSelection(value: $rawSelectedDate)
    }
    
    @ViewBuilder
    var dateSelectionPopover: some View {
        if let chartDescription = viewModel.chartDescription {
            VStack(alignment: .leading) {
                Text(chartDescription.title)
                    .font(Font(UIFont.captionR))
                    .foregroundStyle(Color(UIColor.csGray5))
                
                HStack(spacing: 20) {
                    HStack(spacing: 3) {
                        Text("맞은 개수")
                            .font(Font(UIFont.captionR))
                            .foregroundStyle(Color(UIColor.csBlack))
                        
                        Text("\(chartDescription.okCount)")
                            .font(Font(UIFont.bodySB))
                            .foregroundStyle(Color(UIColor.csBlue5))
                    }
                    HStack(spacing: 3) {
                        Text("틀린 개수")
                            .font(Font(UIFont.captionR))
                            .foregroundStyle(Color(UIColor.csBlack))
                        
                        Text("\(chartDescription.passCount)")
                            .font(Font(UIFont.bodySB))
                            .foregroundStyle(Color.red)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(UIColor.csBlue2), lineWidth: 1)
                    .fill(Color(UIColor.csWhite))
            }
        } else {
            EmptyView()
        }
    }
    
    
    private func chartValue(type: FarmingChartType) -> String {
        switch type {
        case .ok: return "OK"
        case .pass: return "Pass"
        }
    }
    
}
