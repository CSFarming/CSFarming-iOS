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
    func insert(element: FarmingElement) -> Single<Void>
    func removeAll() -> Single<Void>
}

public final class FarmingRepository {
    
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
    
    public func insert(element: FarmingElement) -> Single<Void> {
        let model = FarmingElementModel(types: element.types, date: element.date)
        return storage.insert(model: model)
    }
    
    public func removeAll() -> Single<Void> {
        return storage.removeAll(model: FarmingElementModel.self)
    }
    
}
