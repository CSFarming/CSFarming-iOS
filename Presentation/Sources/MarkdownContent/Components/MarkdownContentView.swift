//
//  MarkdownContentView.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import SwiftUI
import MarkdownUI
import DesignKit

struct MarkdownContentView: View {
    
    @ObservedObject private var content = MarkdownContent()
    
    var body: some View {
        MarkdownNavigationView(title: content.title, action: content.closeAction)
            .frame(height: 50)
            .background(Color(UIColor.csBlue1))
        ScrollView(showsIndicators: false) {
            Markdown(content.source)
                .markdownTheme(.csFarming)
        }
        .padding([.leading, .trailing], 20)
        .background(Color(UIColor.csWhite))
    }
    
    func updateSource(_ source: String) {
        content.source = source
    }
    
    func updateTitle(_ title: String) {
        content.title = title
    }
    
    func updateCloseAction(_ action: (() -> Void)?) {
        content.closeAction = action
    }
    
}
