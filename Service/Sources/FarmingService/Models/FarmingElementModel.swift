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
    
    public let types: [FarmingType]
    public let date: FarmingDate
    
    public init(types: [FarmingType], date: FarmingDate) {
        self.types = types
        self.date = date
    }
    
}

public extension FarmingElementModel {
    
    func toElement() -> FarmingElement {
        return FarmingElement(types: types, date: date)
    }
    
}
