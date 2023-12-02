//
//  HomeAPI.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import BaseService

public enum HomeAPI {
    
    case list
    case detail(path: String)
    
}

extension HomeAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.github)!
    }
    
    public var path: String {
        switch self {
        case .list: return "/CSFarming/CSFarming-Archive/tree/master"
        case .detail(let path): return "\(path)"
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
