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

public enum MarkdownServiceError: Error {
    case earlyExit
}

public protocol MarkdownServiceInterface: AnyObject {
    func requestMarkdownFromRoot(path: String) -> Single<String>
    func requestMarkdown(path: String) -> Single<String>
    func requestVisit(element: ContentElement) -> Single<Void>
    func requestVisitFarming() -> Single<Void>
}

public final class MarkdownService: MarkdownServiceInterface {
    
    private let provider: MoyaProvider<MarkdownAPI>
    private let repository: MarkdownRepositoryInterface
    private let farmingRepository: FarmingRepositoryInterface
    private let calendar: CSCalendarInterface
    
    public init(
        provider: MoyaProvider<MarkdownAPI> = .init(),
        repository: MarkdownRepositoryInterface,
        farmingRepository: FarmingRepositoryInterface,
        calendar: CSCalendarInterface
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
        return repository.insert(element: element)
    }
    
    public func requestVisitFarming() -> Single<Void> {
        return Single<Void>.create { single in
            let request = _Concurrency.Task { [weak self] in
                guard let self else {
                    single(.failure(MarkdownServiceError.earlyExit))
                    return
                }
                do {
                    let element = try await readCurrentFarming().value
                    _ = try await farmingRepository.insert(element: element).value
                    single(.success(()))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func readCurrentFarming() -> Single<FarmingElement> {
        do {
            let date = try calendar.currentDate()
            return farmingRepository
                .readOne(date: date)
                .map { element -> FarmingElement in
                    guard let element else { return FarmingElement(activityScore: 1, date: date, problems: []) }
                    return FarmingElement(activityScore: element.activityScore + 1, date: date, problems: element.problems)
                }
        } catch {
            return .error(error)
        }
    }
    
}
