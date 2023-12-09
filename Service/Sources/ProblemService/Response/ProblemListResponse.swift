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
    let type: String
}

extension ProblemListResponse {
    
    func toElements() -> [ProblemElement] {
        return contents.compactMap { content in
            guard let type = ProblemType(rawValue: content.type) else { return nil }
            return ProblemElement(
                title: content.title,
                content: content.content,
                directory: content.directory,
                type: type
            )}
    }
}
