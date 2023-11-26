//
//  HomeSection.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation

enum HomeSection {
    
    case recentPost([HomeItem])
    case recentProblem([HomeItem])
    
    var items: [HomeItem] {
        switch self {
        case .recentPost(let items): return items
        case .recentProblem(let items): return items
        }
    }
    
    var header: String {
        switch self {
        case .recentPost: return "최근 본 게시글"
        case .recentProblem: return "최근 푼 문제"
        }
    }
    
}

enum HomeItem {
    
    case recentPost(HomePostCellModel)
    case recentProblem(HomeProblemCellModel)
    
}
