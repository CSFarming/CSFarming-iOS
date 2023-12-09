//
//  ProblemListResponse.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import BaseService

struct ProblemListResponse: Decodable {
    let contents: [ProblemContentResponse]
}

struct ProblemContentResponse: Decodable {
    let title: String
    let content: String
    let directory: String
}

extension ProblemListResponse {
    
    func toElements() -> [ProblemElement] {
        return contents.map { ProblemElement(
            title: $0.title,
            content: $0.content,
            directory: $0.directory
        )}
    }
}
