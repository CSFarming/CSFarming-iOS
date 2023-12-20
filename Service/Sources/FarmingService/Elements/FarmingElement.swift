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
    
    public init(activityScore: Int, date: Date) {
        self.activityScore = activityScore
        self.date = date
    }
    
}
