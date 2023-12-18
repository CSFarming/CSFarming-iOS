//
//  QuestionService.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import RxSwift
import Moya
import BaseService

public protocol QuestionServiceInterface: AnyObject {
    func requestQuestions(directory: String) -> Single<QuestionList>
    func requestLocalQuestions() -> Single<[QuestionElement]>
    func insertQuestion(element: QuestionElement) -> Single<Void>
}

public final class QuestionService: QuestionServiceInterface {
    
    private let provider: MoyaProvider<QuestionAPI>
    private let repository: QuestionRepositoryInterface
    
    public init(
        provider: MoyaProvider<QuestionAPI> = .init(),
        repository: QuestionRepositoryInterface
    ) {
        self.provider = provider
        self.repository = repository
    }
    
    public func requestQuestions(directory: String) -> Single<QuestionList> {
        let request: Single<QuestionListResponse> = provider.request(.list(directory))
        return request.map { $0.toElement() }
    }
    
    public func requestLocalQuestions() -> Single<[QuestionElement]> {
        return repository.read()
    }
    
    public func insertQuestion(element: QuestionElement) -> Single<Void> {
        return repository.insert(element: element)
    }
    
}
