//
//  FarmingProblemElement.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation
import BaseService

public struct FarmingProblemElement {
    
    public let title: String
    public let category: String
    public let items: [FarmingProblemElementItem]
    public let createdAt: Date
    public let date: Date
    public let score: Int
    
    public init(title: String, category: String, items: [FarmingProblemElementItem], createdAt: Date, date: Date, score: Int) {
        self.title = title
        self.category = category
        self.items = items
        self.createdAt = createdAt
        self.date = date
        self.score = score
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
