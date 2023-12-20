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
import FarmingService

public protocol MarkdownServiceInterface: AnyObject {
    func requestMarkdownFromRoot(path: String) -> Single<String>
    func requestMarkdown(path: String) -> Single<String>
    func requestVisit(element: ContentElement) -> Single<Void>
}

public final class MarkdownService: MarkdownServiceInterface {
    
    private let provider: MoyaProvider<MarkdownAPI>
    private let repository: MarkdownRepositoryInterface
    private let farmingRepository: FarmingRepositoryInterface
    private let calendar: Calendar
    
    public init(
        provider: MoyaProvider<MarkdownAPI> = .init(),
        repository: MarkdownRepositoryInterface,
        farmingRepository: FarmingRepositoryInterface,
        calendar: Calendar
    ) {
        self.provider = provider
        self.repository = repository
        self.farmingRepository = farmingRepository
        self.calendar = calendar
    }
    
    public func requestMarkdownFromRoot(path: String) -> Single<String> {
        return provider.request(.markdownFromRoot(path: path))
    }
    
    public func requestMarkdown(path: String) -> Single<String> {
        return provider.request(.markdown(path: path))
    }
    
    public func requestVisit(element: ContentElement) -> Single<Void> {
        let year = calendar.component(.year, from: Date.now)
        let month = calendar.component(.month, from: Date.now)
        let day = calendar.component(.day, from: Date.now)
        let date = FarmingDate(year: year, month: month, day: day)
        
        return farmingRepository
            .readOne(date: date)
            .map { element -> FarmingElement in
                guard let element else {
                    return FarmingElement(activityScore: 1, date: .init(year: year, month: month, day: day))
                }
                return FarmingElement(activityScore: element.activityScore + 1, date: element.date)
            }
            .map { [weak self] farmingElement -> Observable<(Void, Void)> in
                guard let self else { return .empty() }
                return Observable.zip(
                    repository.insert(element: element).asObservable(),
                    farmingRepository.insert(element: farmingElement).asObservable()
                )
            }
            .map { _ in () }
    }
    
}
