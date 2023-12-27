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

final class FarmingChartContent: ObservableObject {
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var groups: [FarmingChartGroup] = []
    @Published var closeAction: (() -> Void)? = nil
    
}

struct FarmingChartGroup {
    let type: FarmingChartType
    let elements: [FarmingChartElement]
}

struct FarmingChartElement {
    
    let date: Date
    let value: Int
    
}
