//
//  QuestionList.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation

public struct QuestionList {
    
    public let id: Int
    public let category: String
    public let questions: [Question]
    
    public init(id: Int, category: String, questions: [Question]) {
        self.id = id
        self.category = category
        self.questions = questions
    }
    
}
