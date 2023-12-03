//
//  HomeElementModel.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import SwiftData


@Model
public final class HomeElementModel {
    
    public var title: String
    public var path: String
    public var createdAt: Date
    
    public init(title: String, path: String, createdAt: Date) {
        self.title = title
        self.path = path
        self.createdAt = createdAt
    }
    
}

extension HomeElementModel {
    
    func toElement() -> HomeElement {
        return HomeElement(title: title, path: path)
    }
    
}
