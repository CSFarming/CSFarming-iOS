//
//  FarmingProblemModel.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation
import SwiftData

@Model
public final class FarmingProblemModel {
    
    public let title: String
    public let contents: [FarmingProblemContentItem]
    public let createdAt: Date
    public var element: FarmingElementModel?
    public let score: Int = 10
    
    public init(title: String, contents: [FarmingProblemContentItem], createdAt: Date, element: FarmingElementModel, score: Int) {
        self.title = title
        self.contents = contents
        self.createdAt = createdAt
        self.element = element
        self.score = score
    }
    
}

@Model
public final class FarmingProblemContentItem {
    
    public let question: String
    public let answer: String
    public let isCorrect: Bool
    
    public init(question: String, answer: String, isCorrect: Bool) {
        self.question = question
        self.answer = answer
        self.isCorrect = isCorrect
    }
    
}

extension FarmingProblemModel {
    
    public func toElement(date: Date) -> FarmingProblemElement {
        return .init(
            title: title,
            items: contents.map { $0.toElement() },
            createdAt: createdAt,
            date: date,
            score: score
        )
    }
    
}

extension FarmingProblemContentItem {
    
    public func toElement() -> FarmingProblemElementItem {
        return .init(
            question: question,
            answer: answer,
            isCorrect: isCorrect
        )
    }
    
}
