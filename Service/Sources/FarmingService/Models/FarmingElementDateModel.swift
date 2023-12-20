//
//  FarmingElementDateModel.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import SwiftData

@Model
public final class FarmingElementDateModel {
    
    public let year: Int
    public let month: Int
    public let day: Int
    
    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
}

extension FarmingElementDateModel: Comparable {
    
    public static func < (lhs: FarmingElementDateModel, rhs: FarmingElementDateModel) -> Bool {
        if lhs.year < rhs.year { return true }
        if lhs.month < rhs.month { return true }
        return lhs.day < rhs.day
    }
    
}
