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
    func removeAll() -> Single<Void>
    func insert(element: HomeElement) -> Single<Void>
}

public final class HomeRepository: SwiftDataStorage<HomeElementModel>, HomeRepositoryInterface {
    
    public func read() -> Single<[HomeElement]> {
        let sortBy = SortDescriptor<HomeElementModel>(\.createdAt)
        return super.read(sortBy: [sortBy])
            .map { models in
                return models.map { $0.toElement() }
            }
    }
    
    public func insert(element: HomeElement) -> Single<Void> {
        let model = HomeElementModel(title: element.title, path: element.path, createdAt: Date())
        return super.insert(model: model)
    }
    
}
