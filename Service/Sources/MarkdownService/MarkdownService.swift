//
//  MarkdownService.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import RxSwift
import BaseService

public protocol MarkdownServiceInterface: AnyObject {
    func requestMarkdownFromRoot(path: String) -> Single<String>
    func requestMarkdown(path: String) -> Single<String>
    func requestVisit(element: ContentElement) -> Single<Void>
}

public final class MarkdownService: MarkdownServiceInterface {
    
    private let provider: MoyaProvider<MarkdownAPI>
    private let repository: MarkdownRepositoryInterface
    
    public init(
        provider: MoyaProvider<MarkdownAPI> = .init(),
        repository: MarkdownRepositoryInterface
    ) {
        self.provider = provider
        self.repository = repository
    }
    
    public func requestMarkdownFromRoot(path: String) -> Single<String> {
        return provider.request(.markdownFromRoot(path: path))
    }
    
    public func requestMarkdown(path: String) -> Single<String> {
        return provider.request(.markdown(path: path))
    }
    
    public func requestVisit(element: ContentElement) -> Single<Void> {
        repository.insert(element: element)
    }
    
}
