//
//  MarkdownRepository.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import RxSwift
import BaseService

public protocol MarkdownRepositoryInterface: AnyObject {
    func insert(element: ContentElement) -> Single<Void>
}

public final class MarkdownRepository: MarkdownRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func insert(element: ContentElement) -> Single<Void> {
        let model = ContentElementModel(title: element.title, path: element.path, createdAt: Date())
        return storage.insert(model: model)
    }
    
}
