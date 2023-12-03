//
//  SwiftDataStorage.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import SwiftData
import RxSwift

public enum SwiftDataStorageError: Error {
    case canceled
}

public protocol SwiftDataStorageInterface: AnyObject {
    
    associatedtype T: PersistentModel
    
    func read(sortBy: [SortDescriptor<T>]) -> Single<[T]>
    func read(sortBy: [SortDescriptor<T>], limit: Int) -> Single<[T]>
    func removeAll() -> Single<Void>
    func insert(model: T) -> Single<Void>
    
}

open class SwiftDataStorage<T: PersistentModel>: SwiftDataStorageInterface {
    
    private let container: ModelContainer
    private let context: ModelContext
    
    #warning("강제 언래핑 제거")
    public init() {
        let container = try! ModelContainer(for: T.self)
        self.container = container
        self.context = ModelContext(container)
    }
    
    open func read(sortBy: [SortDescriptor<T>]) async throws -> [T] {
        let descriptor = FetchDescriptor(sortBy: sortBy)
        return try context.fetch(descriptor)
    }
    
    open func read(sortBy: [SortDescriptor<T>], limit: Int) async throws -> [T]  {
        var descriptor = FetchDescriptor(sortBy: sortBy)
        descriptor.fetchLimit = limit
        return try context.fetch(descriptor)
    }
    
    open func removeAll() async throws {
        try context.delete(model: T.self)
    }
    
    open func insert(model: T) async {
        context.insert(model)
    }
    
    open func read(sortBy: [SortDescriptor<T>]) -> Single<[T]> {
        return Single<[T]>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let models = try await read(sortBy: sortBy)
                    single(.success(models))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func read(sortBy: [SortDescriptor<T>], limit: Int) -> Single<[T]> {
        return Single<[T]>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    let models = try await read(sortBy: sortBy, limit: limit)
                    single(.success(models))
                } catch {
                    single(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    open func removeAll() -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                do {
                    try await removeAll()
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
    
    open func insert(model: T) -> Single<Void> {
        return Single<Void>.create { single -> Disposable in
            let request = Task { [weak self] in
                guard let self else {
                    single(.failure(SwiftDataStorageError.canceled))
                    return
                }
                await insert(model: model)
                single(.success(()))
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
}
