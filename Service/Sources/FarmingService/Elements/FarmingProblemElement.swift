//
//  FarmingProblemElement.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation
import BaseService

public struct FarmingProblemElement {
    
    public let items: [FarmingProblemElementItem]
    public let date: Date
    
    public init(items: [FarmingProblemElementItem], date: Date) {
        self.items = items
        self.date = date
    }
    
}

public struct FarmingProblemElementItem {
    
    public let question: String
    public let answer: String
    public let isCorrect: Bool
    
    public init(question: String, answer: String, isCorrect: Bool) {
        self.question = question
        self.answer = answer
        self.isCorrect = isCorrect
    }
    
}
