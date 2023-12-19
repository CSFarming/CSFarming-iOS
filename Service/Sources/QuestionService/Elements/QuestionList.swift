//
//  QuestionList.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation

public struct QuestionList {
    
    public let id: Int
    public let questions: [Question]
    
    public init(id: Int, questions: [Question]) {
        self.id = id
        self.questions = questions
    }
    
}
