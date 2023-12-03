//
//  HomeListResponse.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import BaseService

struct HomeListResponse: Decodable {
    let payload: HomeListPayloadResponse
}

struct HomeListPayloadResponse: Decodable {
    let tree: HomeListTreeResponse
}

struct HomeListTreeResponse: Decodable {
    let items: [HomeListItemResponse]
}

struct HomeListItemResponse: Decodable {
    let name: String?
    let path: String?
    let contentType: String?
}

extension HomeListResponse {
    
    func toElements() -> [ContentElement] {
        return payload.tree.items.compactMap { item in
            guard let title = item.name, let path = item.path else {
                return nil
            }
            return ContentElement(title: title, path: path)
        }
    }
    
}
