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
    public let directory: String
    public let type: ProblemType
    
    public init(title: String, content: String, directory: String, type: ProblemType) {
        self.title = title
        self.content = content
        self.directory = directory
        self.type = type
    }
    
}
