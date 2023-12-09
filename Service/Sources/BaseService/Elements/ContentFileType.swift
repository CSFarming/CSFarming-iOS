//
//  ContentFileType.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation

public enum ContentFileType: Equatable {
    
    case directory
    case markdown
    case unknownFile
    
    init(fileName: String) {
        let fileComponents = fileName.split(separator: ".")
        
        if fileComponents.count == 1 {
            self = .directory
            return
        }
        
        guard let fileExt = fileComponents.last else {
            self = .unknownFile
            return
        }
        
        switch fileExt {
        case "md":
            self = .markdown
            
        default:
            self = .unknownFile
        }
    }
    
}
