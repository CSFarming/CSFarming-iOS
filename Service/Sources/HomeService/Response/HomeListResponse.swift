//
//  HomeListResponse.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation

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
    
    func toElements() -> [HomeElement] {
        return payload.tree.items.compactMap { item in
            guard let title = item.name, let path = item.path else {
                return nil
            }
            return HomeElement(title: title, path: path)
        }
    }
    
}
