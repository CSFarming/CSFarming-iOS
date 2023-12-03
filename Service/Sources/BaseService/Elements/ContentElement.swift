//
//  ContentElement.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation

public struct ContentElement {
    
    public let title: String
    public let path: String
    public let fileType: ContentFileType
    
    public init(title: String, path: String) {
        self.title = title
        self.path = path
        self.fileType = ContentFileType(fileName: title)
    }
    
}
