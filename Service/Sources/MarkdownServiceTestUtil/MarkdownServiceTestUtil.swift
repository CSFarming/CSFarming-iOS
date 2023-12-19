//
//  MarkdownServiceTestUtil.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

import Foundation
import RxSwift
import BaseService
import MarkdownService

public enum MarkdownServiceMockError: Error {
    case requestMarkdownFromRootPathError
    case requestMarkdownPathError
}

public final class MarkdownServiceMock: MarkdownServiceInterface {
    
    public init() {}
    
    public var requestMarkdownFromRootPathCallCount = 0
    public var requestMarkdownFromRootPathPath: String?
    public var requestMarkdownFromRootPathResult: String?
    public func requestMarkdownFromRoot(path: String) -> Single<String> {
        requestMarkdownFromRootPathCallCount += 1
        requestMarkdownFromRootPathPath = path
        
        if let requestMarkdownFromRootPathResult {
            return .just(requestMarkdownFromRootPathResult)
        } else {
            return .error(MarkdownServiceMockError.requestMarkdownFromRootPathError)
        }
    }
    
    public var requestMarkdownPathCallCount = 0
    public var requestMarkdownPath: String?
    public var requestMarkdownPathResult: String?
    public func requestMarkdown(path: String) -> Single<String> {
        requestMarkdownPathCallCount += 1
        requestMarkdownPath = path
        
        if let requestMarkdownPathResult {
            return .just(requestMarkdownPathResult)
        } else {
            return .error(MarkdownServiceMockError.requestMarkdownPathError)
        }
    }
    
    public var requestVisitElementCallCount = 0
    public var requestVisitElementElement: ContentElement?
    public func requestVisit(element: ContentElement) -> Single<Void> {
        requestVisitElementCallCount += 1
        requestVisitElementElement = element
        return .just(())
    }
    
}
