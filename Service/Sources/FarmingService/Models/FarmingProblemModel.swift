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
    
    public let contents: [FarmingProblemContentItem]
    public var element: FarmingElementModel?
    
    public init(contents: [FarmingProblemContentItem], element: FarmingElementModel) {
        self.contents = contents
        self.element = element
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
        return .init(items: contents.map { $0.toElement() }, date: date)
    }
    
}

extension FarmingProblemContentItem {
    
    public func toElement() -> FarmingProblemElementItem {
        return .init(question: question, answer: answer, isCorrect: isCorrect)
    }
    
}
