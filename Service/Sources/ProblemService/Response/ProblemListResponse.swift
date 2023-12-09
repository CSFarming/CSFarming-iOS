//
//  ProblemListResponse.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import BaseService

struct ProblemListResponse: Decodable {
    let payload: ProblemListPayloadResponse
}

struct ProblemListPayloadResponse: Decodable {
    let tree: ProblemListTreeResponse
}

struct ProblemListTreeResponse: Decodable {
    let items: [ProblemListItemResponse]
}

struct ProblemListItemResponse: Decodable {
    let name: String?
    let path: String?
    let contentType: String?
}

extension ProblemListResponse {
    
    func toElements() -> [ContentElement] {
        return payload.tree.items.compactMap { item in
            guard let title = item.name, let path = item.path else {
                return nil
            }
            return ContentElement(title: title, path: path)
        }
    }
    
}
