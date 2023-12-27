//
//  FarmingHomeSection.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation

enum FarmingHomeSection {
    case statistics([FarmingHomeItem])
    case farming([FarmingHomeItem])
    
    var items: [FarmingHomeItem] {
        switch self {
        case .statistics(let items): return items
        case .farming(let items): return items
        }
    }
    
    var header: String {
        switch self {
        case .statistics: return "통계 자료"
        case .farming: return "오늘의 파밍"
        }
    }
    
}

enum FarmingHomeItem {
    case study(FarmingHomeCellModel)
    case problem(FarmingHomeSelectableCellModel)
    case chart(FarmingHomeChartCellModel)
    case empty
}
