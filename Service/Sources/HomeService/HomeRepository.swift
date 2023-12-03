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
    func read() -> Single<[ContentElement]>
    func removeAll() -> Single<Void>
    func insert(element: ContentElement) -> Single<Void>
}

public final class HomeRepository: SwiftDataStorage<ContentElementModel>, HomeRepositoryInterface {
    
    public func read() -> Single<[ContentElement]> {
        let sortBy = SortDescriptor<ContentElementModel>(\.createdAt)
        return super.read(sortBy: [sortBy])
            .map { models in
                return models.map { $0.toElement() }
            }
    }
    
    public func insert(element: ContentElement) -> Single<Void> {
        let model = ContentElementModel(title: element.title, path: element.path, createdAt: Date())
        return super.insert(model: model)
    }
    
}
