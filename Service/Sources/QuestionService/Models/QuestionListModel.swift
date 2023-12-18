//
//  QuestionListModel.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import Foundation
import SwiftData

@Model
public final class QuestionListModel {
    
    public var title: String
    public var subtitle: String
    public var questions: [QuestionModel]
    public var createdAt: Date
    
    public init(title: String, subtitle: String, questions: [QuestionModel], createdAt: Date) {
        self.title = title
        self.subtitle = subtitle
        self.questions = questions
        self.createdAt = createdAt
    }
    
}

public extension QuestionListModel {
    
    func toElement() -> QuestionElement {
        return QuestionElement(
            title: title, 
            subtitle: subtitle, 
            questions: questions.map { .init(question: $0.question, answer: $0.answer) }
        )
    }
    
}

@Model
public final class QuestionModel {
    
    public var question: String
    public var answer: String
    
    public init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
    
}

