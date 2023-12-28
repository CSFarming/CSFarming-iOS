//
//  FarmingChartContent.swift
//
//
//  Created by 홍성준 on 12/26/23.
//

import Foundation

enum FarmingChartType: String, Identifiable, CaseIterable {
    case ok = "맞음"
    case pass = "틀림"
    var id: String { rawValue }
}

struct FarmingChartContent {
    let description: String
    let groups: [FarmingChartGroup]
    
    init(description: String = "", groups: [FarmingChartGroup] = []) {
        self.description = description
        self.groups = groups
    }
}

struct FarmingChartElement {
    let date: Date
    let value: Int
}
