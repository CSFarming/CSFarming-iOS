//
//  HomeElement.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import BaseService

public struct HomeElement {
    
    public let title: String
    public let path: String
    public let createdAt: Date
    
    public init(title: String, path: String, createdAt: Date) {
        self.title = title
        self.path = path
        self.createdAt = createdAt
    }
    
}
public extension ContentElementModel {
    
    func toHomeElement() -> HomeElement {
        return HomeElement(title: title, path: path, createdAt: createdAt)
    }
    
}
