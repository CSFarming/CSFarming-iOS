//
//  ProblemAPI.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import Moya
import BaseService

public enum ProblemAPI {
    
    case list
    case problem(String)
    
}

extension ProblemAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.githubRaw)!
    }
    
    public var path: String {
        switch self {
        case .list:
            return "/CSFarming/CSFarming-Problem-Archive/master/Contents.json"
            
        case .problem(let directory):
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
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
