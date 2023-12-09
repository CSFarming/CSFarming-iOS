//
//  ContentElementFilteringOption.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation

public enum ContentElementFilteringOption {
    
    case `default`
    case directoryOnly
    
}

extension ContentElementFilteringOption {
    
    var exceptFiles: [String] {
        switch self {
        case .default:
            return ["README.md", "readme.md", "dummy.md"]
            
        case .directoryOnly:
            return []
        }
    }
    
    var exceptFileTypes: [ContentFileType] {
        switch self {
        case .default:
            return []
            
        case .directoryOnly:
            return [.markdown, .unknownFile]
        }
    }
    
}

public extension ContentElement {
    
    func isEnabled(option: ContentElementFilteringOption = .default) -> Bool {
        let exceptFiles = option.exceptFiles
        let exceptFileTypes = option.exceptFileTypes
        return !exceptFiles.contains(where: { $0 == title }) && !exceptFileTypes.contains(where: { $0 == fileType })
    }
    
}
