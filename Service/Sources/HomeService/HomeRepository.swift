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

public final class HomeRepository: SwiftDataStorage<ContentElementModel>, HomeRepositoryInterface {
    
    public func read() -> Single<[HomeElement]> {
        let sortBy = SortDescriptor<ContentElementModel>(\.createdAt, order: .reverse)
        return super.read(sortBy: [sortBy])
            .map { models in
                return models.map { $0.toHomeElement() }
            }
    }
    
    public func read(limit: Int) -> Single<[HomeElement]> {
        let sortBy = SortDescriptor<ContentElementModel>(\.createdAt, order: .reverse)
        return super.read(sortBy: [sortBy], limit: limit)
            .map { models in
                return models.map { $0.toHomeElement() }
            }
    }
    
    public func insert(element: HomeElement) -> Single<Void> {
        let model = ContentElementModel(title: element.title, path: element.path, createdAt: Date())
        return super.insert(model: model)
    }
    
}
