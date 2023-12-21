//
//  FarmingElement.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import BaseService

public struct FarmingElement {
    
    public let activityScore: Int
    public let date: Date
    public let problems: [FarmingProblemElement]
    
    public var totalScore: Int {
        return activityScore + problems.map(\.score).reduce(0, +)
    }
    
    public init(activityScore: Int, date: Date, problems: [FarmingProblemElement]) {
        self.activityScore = activityScore
        self.date = date
        self.problems = problems
    }
    
}

extension FarmingElement: Equatable {
    
    public static func == (lhs: FarmingElement, rhs: FarmingElement) -> Bool {
        return lhs.activityScore == rhs.activityScore && lhs.date == rhs.date && lhs.problems.count == rhs.problems.count
    }
    
}
