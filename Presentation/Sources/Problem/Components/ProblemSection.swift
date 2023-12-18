//
//  ProblemSection.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import Foundation

enum ProblemSection {
    
    case remote([ProblemItem])
    case local([ProblemItem])
    
    var items: [ProblemItem] {
        switch self {
        case .remote(let items): return items
        case .local(let items): return items
        }
    }
    
    var header: String {
        switch self {
        case .remote: return "카테고리"
        case .local: return "내가 쓴 문제"
        }
    }
    
}

enum ProblemItem {
    case remote(ProblemContentCellModel)
    case local(LocalProblemContentCellModel)
}
