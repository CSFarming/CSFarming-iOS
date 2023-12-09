//
//  QuestionAPI.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import Moya
import BaseService

public enum QuestionAPI {
    
    case list(String)
    
}

extension QuestionAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.githubRaw)!
    }
    
    public var path: String {
        switch self {
        case .list(let directory):
            return "/CSFarming/CSFarming-Problem-Archive/master/\(directory)/Contents.json"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return NetworkHeader.withJSON
    }
    
}
