//
//  QuestionRepository.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import Foundation
import SwiftData
import RxSwift
import BaseService

public protocol QuestionRepositoryInterface: AnyObject {
    func read() -> Single<[QuestionElement]>
    func insert(element: QuestionElement) -> Single<Void>
}

public final class QuestionRepository: QuestionRepositoryInterface {
    
    private let storage: SwiftDataStorageInterface
    
    public init(storage: SwiftDataStorageInterface) {
        self.storage = storage
    }
    
    public func read() -> Single<[QuestionElement]> {
        let sortBy = SortDescriptor<QuestionListModel>(\.createdAt, order: .reverse)
        return storage.read(sortBy: [sortBy])
            .map { models in
                return models.map { $0.toElement() }
            }
    }
    
    public func insert(element: QuestionElement) -> Single<Void> {
        let model = QuestionListModel(
            title: element.title,
            subtitle: element.subtitle,
            category: element.category,
            questions: element.questions.map { .init(question: $0.question, answer: $0.answer) },
            createdAt: Date()
        )
        return storage.insert(model: model)
    }
    
}
