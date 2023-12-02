//
//  MarkdownAPI.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import BaseService

public enum MarkdownAPI {
    
    case markdownFromRoot(path: String)
    case markdown(path: String)
    
}

extension MarkdownAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.githubRaw)!
    }
    
    public var path: String {
        switch self {
        case .markdownFromRoot(let path):
            return path.replacingOccurrences(of: "/blob", with: "")
        case .markdown(let path):
            return "/CSFarming/CSFarming-Archive/master/\(path)"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
