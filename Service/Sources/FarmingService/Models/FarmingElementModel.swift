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
    @Attribute(.unique) let date: FarmingElementDateModel
    
    public init(activityScore: Int, date: FarmingDate) {
        self.activityScore = activityScore
        self.date = FarmingElementDateModel(year: date.year, month: date.month, day: date.day)
    }
    
}

public extension FarmingElementModel {
    
    func toElement() -> FarmingElement {
        return FarmingElement(
            activityScore: activityScore, 
            date: .init(year: date.year, month: date.month, day: date.day)
        )
    }
    
}
