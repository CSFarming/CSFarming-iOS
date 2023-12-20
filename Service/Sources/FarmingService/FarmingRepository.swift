//
//  FarmingRepository.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import RxSwift
import BaseService

public protocol FarmingRepositoryInterface: AnyObject {
    func read(limit: Int) -> Single<[FarmingElement]>
    func readOne(date: Date) -> Single<FarmingElement?>
    func insert(element: FarmingElement) -> Single<Void>
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
    
    public func readOne(date: Date) -> Single<FarmingElement?> {
        let predicate = #Predicate<FarmingElementModel> {
            $0.date == date
        }
        
        return storage.readOne(predicate: predicate)
            .map { $0?.toElement() }
    }
    
    public func insert(element: FarmingElement) -> Single<Void> {
        let date = element.date
        let predicate = #Predicate<FarmingElementModel> {
            $0.date == date
        }
        let model = FarmingElementModel(
            activityScore: element.activityScore,
            date: element.date
        )
        return storage.upsert(model: model, predicate: predicate)
    }
    
    public func removeAll() -> Single<Void> {
        return storage.removeAll(model: FarmingElementModel.self)
    }
    
}
