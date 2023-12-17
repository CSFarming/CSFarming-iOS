//
//  QuestionElement.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation

public struct QuestionList {
    
    public let id: Int
    public let questions: [Question]
    
}

public struct Question {
    
    public let question: String
    public let answer: String
    
}
