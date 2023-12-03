//
//  ArchiveListResponse.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import BaseService

struct ArchiveListResponse: Decodable {
    let payload: ArchiveListPayloadResponse
}

struct ArchiveListPayloadResponse: Decodable {
    let tree: ArchiveListTreeResponse
}

struct ArchiveListTreeResponse: Decodable {
    let items: [ArchiveListItemResponse]
}

struct ArchiveListItemResponse: Decodable {
    let name: String?
    let path: String?
    let contentType: String?
}

extension ArchiveListResponse {
    
    func toElements() -> [ContentElement] {
        return payload.tree.items.compactMap { item in
            guard let title = item.name, let path = item.path else {
                return nil
            }
            return ContentElement(title: title, path: path)
        }
    }
    
}
