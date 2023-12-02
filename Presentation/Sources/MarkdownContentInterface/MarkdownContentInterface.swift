//
//  MarkdownContentInterface.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs

public protocol MarkdownContentBuildable: Buildable {
    func build(withListener listener: MarkdownContentListener, title: String, path: String, isFromRoot: Bool) -> ViewableRouting
}

public protocol MarkdownContentListener: AnyObject {
    func markdownContentDidTapClose()
}
