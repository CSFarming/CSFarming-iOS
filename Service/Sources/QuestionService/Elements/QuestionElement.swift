//
//  QuestionElement.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import Foundation

public struct QuestionElement {
    
    public let title: String
    public let subtitle: String
    public let category: String
    public let questions: [Question]
    
    public init(title: String, subtitle: String, category: String, questions: [Question]) {
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.questions = questions
    }
    
}
