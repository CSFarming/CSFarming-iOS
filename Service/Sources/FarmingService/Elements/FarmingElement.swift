//
//  FarmingElement.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import BaseService

public enum FarmingType {
    case article
    case problem
}

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
    
    public let types: [FarmingType]
    public let date: FarmingDate
    
    public init(types: [FarmingType], date: FarmingDate) {
        self.types = types
        self.date = date
    }
    
}

extension FarmingDate: Comparable {
    
    public static func < (lhs: FarmingDate, rhs: FarmingDate) -> Bool {
        if lhs.year < rhs.year { return true }
        if lhs.month < rhs.month { return true }
        return lhs.day < rhs.day
    }
    
    
}
