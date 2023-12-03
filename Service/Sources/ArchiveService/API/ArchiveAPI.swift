//
//  ArchiveAPI.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import Moya
import BaseService

public enum ArchiveAPI {
    
    case list
    case detail(path: String)
    case detailWithPrefix(path: String)
    
}

extension ArchiveAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.github)!
    }
    
    public var path: String {
        switch self {
        case .list:
            return "/CSFarming/CSFarming-Archive/tree/master"
            
        case .detail(let path):
            return "\(path)"
            
        case .detailWithPrefix(let path):
            return "/CSFarming/CSFarming-Archive/tree/master/\(path)"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        switch self {
        case .list:
            return nil
            
        default:
            return NetworkHeader.withJSON
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
