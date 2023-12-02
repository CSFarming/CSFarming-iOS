//
//  MarkdownService.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import Markdown
import RxSwift
import BaseService

public protocol MarkdownServiceInterface: AnyObject {
    func requestMarkdownFromRoot(path: String) -> Single<String>
    func requestMarkdown(path: String) -> Single<String>
}

public final class MarkdownService: MarkdownServiceInterface {
    
    private let provider: MoyaProvider<MarkdownAPI>
    
    public init(
        provider: MoyaProvider<MarkdownAPI> = .init()
    ) {
        self.provider = provider
    }
    
    public func requestMarkdownFromRoot(path: String) -> Single<String> {
        return provider.request(.markdownFromRoot(path: path))
    }
    
    public func requestMarkdown(path: String) -> Single<String> {
        return provider.request(.markdown(path: path))
    }
    
}
