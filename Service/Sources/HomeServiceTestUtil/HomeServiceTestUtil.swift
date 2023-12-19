//
//  HomeServiceTestUtil.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

import Foundation
import RxSwift
import BaseService
import HomeService

public final class HomeServiceMock: HomeServiceInterface {
    
    public let currentHistorySubject = PublishSubject<[HomeElement]>()
    public var currentHistory: Observable<[HomeElement]> {
        currentHistorySubject.asObservable()
    }
    
    public var requestVisitHistoryCallCount = 0
    public func requestVisitHistory() {
        requestVisitHistoryCallCount += 1
    }
    
    public var requestRemoveAllCallCount = 0
    public func requestRemoveAll() -> Single<Void> {
        requestRemoveAllCallCount += 1
        return .just(())
    }
    
}
