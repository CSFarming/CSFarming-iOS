//
//  FarmingElementModel.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import SwiftData

@Model
public final class FarmingElementModel {
    
    public let activityScore: Int
    
    @Attribute(.unique)
    public let date: Date
    
    @Relationship(deleteRule: .cascade, inverse: \FarmingProblemModel.element)
    public var problems: [FarmingProblemModel] = []
    
    @Transient
    public var totalScore: Int {
        return activityScore + problems.map(\.score).reduce(0, +)
    }
    
    public init(activityScore: Int, date: Date) {
        self.activityScore = activityScore
        self.date = date
    }
    
}

public extension FarmingElementModel {
    
    func toElement() -> FarmingElement {
        return FarmingElement(
            activityScore: activityScore, 
            date: date,
            problems: problems
                .sorted(by: { $0.createdAt > $1.createdAt })
                .map { $0.toElement(date: date) }
        )
    }
    
}
