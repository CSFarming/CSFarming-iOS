//
//  FarmingRepository.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import RxSwift
import BaseService

public enum FarmingRepositoryError: Error {
    case earlyExit
    case emptyRelatedModel
}

public protocol FarmingRepositoryInterface: AnyObject {
    func read(limit: Int) -> Single<[FarmingElement]>
    func readOne(date: Date) -> Single<FarmingElement?>
    func read(minimumDate: Date) -> Single<[FarmingElement]>
    func insert(element: FarmingElement) -> Single<Void>
    func insert(element: FarmingProblemElement) -> Single<Void>
    func removeAll() -> Single<Void>
}

public final class FarmingRepository: FarmingRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func read(limit: Int) -> Single<[FarmingElement]> {
        let sortBy = SortDescriptor<FarmingElementModel>(\.date, order: .reverse)
        return storage.read(sortBy: [sortBy], limit: limit)
            .map { models in
                return models.map { $0.toElement() }
            }
    }
    
    public func read(minimumDate: Date) -> Single<[FarmingElement]> {
        let predicate = #Predicate<FarmingElementModel> {
            $0.date > minimumDate
        }
        return storage.read(predicate: predicate)
            .map { models in
                return models.map { $0.toElement() }
            }
    }
    
    public func readOne(date: Date) -> Single<FarmingElement?> {
        let predicate = #Predicate<FarmingElementModel> {
            $0.date == date
        }
        
        return storage.readOne(predicate: predicate)
            .map { $0?.toElement() }
    }
    
    public func insert(element: FarmingElement) -> Single<Void> {
        let model = FarmingElementModel(
            activityScore: element.activityScore,
            date: element.date
        )
        return storage.insert(model: model)
    }
    
    public func insert(element: FarmingProblemElement) -> Single<Void> {
        return Single<Void>.create { single in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(FarmingRepositoryError.earlyExit))
                    return
                }
                do {
                    try await insert(element: element)
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
    
    public func removeAll() -> Single<Void> {
        return storage.removeAll(model: FarmingElementModel.self)
    }
    
    private func insert(element: FarmingProblemElement) async throws {
        let date = element.date
        let predicate = #Predicate<FarmingElementModel> {
            $0.date == date
        }
        let farmingElement: FarmingElementModel = try await {
            if let farmingElement = try? await storage.readOne(predicate: predicate).value {
                return farmingElement
            }
            try await insert(element: .init(activityScore: 0, date: date, problems: [])).value
            guard let farmingElement = try await storage.readOne(predicate: predicate).value else {
                throw FarmingRepositoryError.emptyRelatedModel
            }
            return farmingElement
        }()
        
        let contents: [FarmingProblemContentItem] = element.items.map { .init(
            question: $0.question,
            answer: $0.answer,
            isCorrect: $0.isCorrect
        )}
        let model = FarmingProblemModel(
            title: element.title,
            category: element.category,
            contents: contents,
            createdAt: element.createdAt,
            element: farmingElement,
            score: element.score
        )
        try await storage.insert(model: model).value
    }
    
}
