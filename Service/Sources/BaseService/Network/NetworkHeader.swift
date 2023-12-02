//
//  NetworkHeader.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation

public enum NetworkHeader {
    
    public static var withJSON: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
    
}
