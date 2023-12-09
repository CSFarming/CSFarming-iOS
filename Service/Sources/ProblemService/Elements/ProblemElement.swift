//
//  ProblemElement.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation

public struct ProblemElement {
    
    public let title: String
    public let content: String
    public let url: String
    
    public init(title: String, content: String, url: String) {
        self.title = title
        self.content = content
        self.url = url
    }
    
}
