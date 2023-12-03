//
//  HomeService.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import RxSwift
import BaseService

public protocol HomeServiceInterface: HomeVisitServiceInterface {}

public final class HomeService: HomeServiceInterface {
    
    private let repository: HomeRepositoryInterface
    
    public init(repository: HomeRepositoryInterface) {
        self.repository = repository
    }
    
    public func requestVisitHistory() -> Single<[ContentElement]> {
        return repository.read(limit: 5)
    }
    
    public func requestRemoveAll() -> Single<Void> {
        return repository.removeAll()
    }
    
}
