//
//  QuestionListResponse.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation

struct QuestionListResponse: Decodable {
    
    let id: Int
    let contents: [QuestionContentResponse]
}

struct QuestionContentResponse: Decodable {
    
    let question: String
    
}

extension QuestionListResponse {
    
    func toElement() -> QuestionList {
        return .init(id: id, questions: contents.map(\.question))
    }
    
}
