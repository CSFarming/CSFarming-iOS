//
//  ContentElementModel.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import SwiftData

@Model
public final class ContentElementModel {
    
    @Attribute(.unique) public var title: String
    public var path: String
    public var createdAt: Date
    
    public init(title: String, path: String, createdAt: Date) {
        self.title = title
        self.path = path
        self.createdAt = createdAt
    }
    
}

public extension ContentElementModel {
    
    func toElement() -> ContentElement {
        return ContentElement(title: title, path: path)
    }
    
}
