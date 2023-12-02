//
//  MarkdownContent.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation

final class MarkdownContent: ObservableObject {
    
    @Published var source: String = ""
    
    func update(_ source: String) {
        self.source = source
    }
    
}
