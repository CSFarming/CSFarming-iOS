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
import FarmingService

public enum QuestionServiceError: Error {
    case invalidDate
}

public protocol QuestionServiceInterface: AnyObject {
    func requestQuestions(directory: String) -> Single<QuestionList>
    func requestLocalQuestions() -> Single<[QuestionElement]>
    func insertQuestion(element: QuestionElement) -> Single<Void>
    func insertQuestionResult(items: [FarmingProblemElementItem]) -> Single<Void>
}

public final class QuestionService: QuestionServiceInterface {
    
    private let provider: MoyaProvider<QuestionAPI>
    private let repository: QuestionRepositoryInterface
    private let farmingRepository: FarmingRepositoryInterface
    private let calendar: Calendar
    
    public init(
        provider: MoyaProvider<QuestionAPI> = .init(),
        repository: QuestionRepositoryInterface,
        farmingRepository: FarmingRepositoryInterface,
        calendar: Calendar
    ) {
        self.provider = provider
        self.repository = repository
        self.farmingRepository = farmingRepository
        self.calendar = calendar
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
    
    public func insertQuestionResult(items: [FarmingProblemElementItem]) -> Single<Void> {
        do {
            let date = try generateCurrentDate()
            let element = FarmingProblemElement(items: items, date: date)
            return farmingRepository.insert(element: element)
        } catch {
            return .error(error)
        }
    }
    
    private func generateCurrentDate() throws ->  Date {
        let year = calendar.component(.year, from: .now)
        let month = calendar.component(.month, from: .now)
        let day = calendar.component(.day, from: .now)
        
        guard let date = calendar.date(from: .init(year: year, month: month, day: day)) else {
            throw QuestionServiceError.invalidDate
        }
        return date
    }
    
}
