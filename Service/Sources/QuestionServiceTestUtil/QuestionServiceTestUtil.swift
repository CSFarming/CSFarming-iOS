//
//  QuestionServiceTestUtil.swift
//  
//
//  Created by 홍성준 on 12/19/23.
//

import Foundation
import RxSwift
import BaseService
import QuestionService

public enum QuestionServiceMockError: Error {
    case requestQuestionsDirectoryError
    case requestLocalQuestionsError
}

public final class QuestionServiceMock: QuestionServiceInterface {
    
    public init() {}
    
    public var requestQuestionsDirectoryCallCount = 0
    public var requestQuestionsDirectoryDirectory: String?
    public var requestQuestionsDirectoryResult: QuestionList?
    public func requestQuestions(directory: String) -> Single<QuestionList> {
        requestQuestionsDirectoryCallCount += 1
        requestQuestionsDirectoryDirectory = directory
        
        if let requestQuestionsDirectoryResult {
            return .just(requestQuestionsDirectoryResult)
        } else {
            return .error(QuestionServiceMockError.requestQuestionsDirectoryError)
        }
    }
    
    public var requestLocalQuestionsCallCount = 0
    public var requestLocalQuestionsResult: [QuestionElement]?
    public func requestLocalQuestions() -> Single<[QuestionElement]> {
        requestLocalQuestionsCallCount += 1
        
        if let requestLocalQuestionsResult {
            return .just(requestLocalQuestionsResult)
        } else {
            return .error(QuestionServiceMockError.requestLocalQuestionsError)
        }
    }
    
    public var insertQuestionElementCallCount = 0
    public var insertQuestionElementElement: QuestionElement?
    public func insertQuestion(element: QuestionElement) -> Single<Void> {
        insertQuestionElementCallCount += 1
        insertQuestionElementElement = element
        return .just(())
    }    
    
}
