//
//  ArchiveServiceTestUtil.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

import Foundation
import RxSwift
import BaseService
import ArchiveService

public enum ArchiveServiceMockError: Error {
    case requestElementsError
    case requestElementsPathError
    case requestElementsWithPrefixPathError
}

public final class ArchiveServiceMock: ArchiveServiceInterface {
    
    public init() {}
    
    public var requestElementsCallCount = 0
    public var requestElementsResult: [ContentElement]?
    public func requestElements() -> Single<[ContentElement]> {
        requestElementsCallCount += 1
        if let requestElementsResult {
            return .just(requestElementsResult)
        } else {
            return .error(ArchiveServiceMockError.requestElementsError)
        }
    }
    
    public var requestElementsPathCallCount = 0
    public var requestElementsPathPath: String?
    public var requestElementsPathElements: [ContentElement]?
    public func requestElements(path: String) -> Single<[ContentElement]> {
        requestElementsPathCallCount += 1
        requestElementsPathPath = path
        if let requestElementsPathElements {
            return .just(requestElementsPathElements)
        } else {
            return .error(ArchiveServiceMockError.requestElementsPathError)
        }
    }
    
    public var requestElementsWithPrefixPathCallCount = 0
    public var requestElementsWithPrefixPathPath: String?
    public var requestElementsWithPrefixPathElements: [ContentElement]?
    public func requestElementsWithPrefix(path: String) -> Single<[ContentElement]> {
        requestElementsWithPrefixPathCallCount += 1
        requestElementsWithPrefixPathPath = path
        if let requestElementsWithPrefixPathElements {
            return .just(requestElementsWithPrefixPathElements)
        } else {
            return .error(ArchiveServiceMockError.requestElementsWithPrefixPathError)
        }
    }
    
}
