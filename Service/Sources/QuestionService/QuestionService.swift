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
}

public final class QuestionService: QuestionServiceInterface {
    
    private let provider: MoyaProvider<QuestionAPI>
    
    public init(provider: MoyaProvider<QuestionAPI> = .init()) {
        self.provider = provider
    }
    
    public func requestQuestions(directory: String) -> Single<QuestionList> {
        let request: Single<QuestionListResponse> = provider.request(.list(directory))
        return request.map { $0.toElement() }
    }
    
    
}
