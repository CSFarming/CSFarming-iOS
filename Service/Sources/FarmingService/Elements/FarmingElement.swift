//
//  FarmingElement.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import BaseService

public struct FarmingDate {
    
    public let year: Int
    public let month: Int
    public let day: Int
    
    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
}

public struct FarmingElement {
    
    public let activityScore: Int
    public let date: FarmingDate
    
    public init(activityScore: Int, date: FarmingDate) {
        self.activityScore = activityScore
        self.date = date
    }
    
}

extension FarmingDate {
    
    static func == (lhs: FarmingDate, rhs: FarmingElementDateModel) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
    
}
