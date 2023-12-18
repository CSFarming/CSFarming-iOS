//
//  HomeRepository.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import RxSwift
import BaseService

public protocol HomeRepositoryInterface: AnyObject {
    func read() -> Single<[HomeElement]>
    func read(limit: Int) -> Single<[HomeElement]>
    func removeAll() -> Single<Void>
    func insert(element: HomeElement) -> Single<Void>
}

public final class HomeRepository: HomeRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func read() -> Single<[HomeElement]> {
        let sortBy = SortDescriptor<ContentElementModel>(\.createdAt, order: .reverse)
        return storage.read(sortBy: [sortBy])
            .map { models in
                return models.map { $0.toHomeElement() }
            }
    }
    
    public func read(limit: Int) -> Single<[HomeElement]> {
        let sortBy = SortDescriptor<ContentElementModel>(\.createdAt, order: .reverse)
        return storage.read(sortBy: [sortBy], limit: limit)
            .map { models in
                return models.map { $0.toHomeElement() }
            }
    }
    
    public func insert(element: HomeElement) -> Single<Void> {
        let model = ContentElementModel(title: element.title, path: element.path, createdAt: Date())
        return storage.insert(model: model)
    }
    
    public func removeAll() -> Single<Void> {
        return storage.removeAll(model: ContentElementModel.self)
    }
    
}
