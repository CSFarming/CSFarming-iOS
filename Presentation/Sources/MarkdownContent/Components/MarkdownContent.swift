//
//  MarkdownContent.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation

final class MarkdownContent: ObservableObject {
    
    @Published var source: String = ""
    @Published var title: String = ""
    @Published var closeAction: (() -> Void)? = nil
    
    func update(_ source: String) {
        self.source = source
    }
    
    func updateTitle(_ title: String) {
        self.title = title
    }
    
    func updateCloseAction(_ action: (() -> Void)?) {
        self.closeAction = action
    }
    
}
