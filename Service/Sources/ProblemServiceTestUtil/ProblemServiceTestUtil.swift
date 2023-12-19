//
//  ProblemServiceTestUtil.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

import Foundation
import RxSwift
import BaseService
import ProblemService

public enum ProblemServiceMockError: Error {
    case requestElementsError
    case requestElementsDirectoryError
}

public final class ProblemServiceMock: ProblemServiceInterface {
    
    public var requestElementsCallCount = 0
    public var requestElementsResult: [ProblemElement]?
    public func requestElements() -> Single<[ProblemElement]> {
        requestElementsCallCount += 1
        
        if let requestElementsResult {
            return .just(requestElementsResult)
        } else {
            return .error(ProblemServiceMockError.requestElementsError)
        }
    }
    
    public var requestElementsDirectoryCallCount = 0
    public var requestElementsDirectoryDirectory: String?
    public var requestElementsDirectoryResult: [ProblemElement]?
    public func requestElements(directory: String) -> Single<[ProblemElement]> {
        requestElementsDirectoryCallCount += 1
        requestElementsDirectoryDirectory = directory
        
        if let requestElementsDirectoryResult {
            return .just(requestElementsDirectoryResult)
        } else {
            return .error(ProblemServiceMockError.requestElementsDirectoryError)
        }
    }
    
}
