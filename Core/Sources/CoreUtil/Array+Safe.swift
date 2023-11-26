//
//  Array+Safe.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation

public extension Array {
    
    subscript(safe index: Int) -> Element? {
        self.indices ~= index ? self[index] : nil
    }
    
}
