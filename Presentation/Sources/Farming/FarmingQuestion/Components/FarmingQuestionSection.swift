//
//  FarmingQuestionSection.swift
//
//
//  Created by 홍성준 on 12/23/23.
//

import Foundation
import CoreUtil

enum FarmingQuestionSection {
    
    case ok([FarmingQuestionCellModel])
    case pass([FarmingQuestionCellModel])
    
    var title: String {
        switch self {
        case .ok: return "잘 알고 있어요"
        case .pass: return "잘 모르겠어요"
        }
    }
    
    var items: [FarmingQuestionCellModel] {
        switch self {
        case .ok(let items): return items
        case .pass(let items): return items
        }
    }
    
}

extension Array where Element == FarmingQuestionSection {
    
    func updating(at indexPath: IndexPath, model: FarmingQuestionCellModel) -> [Element] {
        var sections: [Element] = self
        let section = sections[indexPath.section]
        var items = section.items
        items[indexPath.row] = model
        
        switch section {
        case .ok:
            sections[indexPath.section] = .ok(items)
            
        case .pass:
            sections[indexPath.section] = .pass(items)
        }
        
        return sections
    }
    
}
