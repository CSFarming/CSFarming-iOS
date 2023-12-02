//
//  MarkdownContentView.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import SwiftUI

struct MarkdownContentView: View {
    
    @ObservedObject var content = MarkdownContent()
    
    var body: some View {
        Text(content.source)
    }
    
}
