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
    
}

extension ProblemAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.githubRaw)!
    }
    
    public var path: String {
        switch self {
        case .list:
            return "/CSFarming/CSFarming-Problem-Archive/master/Contents.json"
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
