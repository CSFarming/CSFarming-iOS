//
//  HomeService.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import RxSwift
import RxRelay
import BaseService
import FarmingService

public protocol HomeServiceInterface: HomeVisitServiceInterface {}

public final class HomeService: HomeServiceInterface {
    
    public var currentHistory: Observable<[HomeElement]> {
        return historyRelay.asObservable()
    }
    
    public var farmingList: Observable<[FarmingElement]> {
        return farmingRelay.asObservable()
    }
    
    private let repository: HomeRepositoryInterface
    private let farmingRepository: FarmingRepositoryInterface
    private let historyRelay = PublishRelay<[HomeElement]>()
    private let farmingRelay = PublishRelay<[FarmingElement]>()
    private let historyLimit = 5
    private let refreshSeconds = 60 // 1분
    private let disposeBag = DisposeBag()
    private var lastUpdated: Date?
    
    public init(
        repository: HomeRepositoryInterface,
        farmingRepository: FarmingRepositoryInterface
    ) {
        self.repository = repository
        self.farmingRepository = farmingRepository
    }
    
    public func requestVisitHistory() {
        if let lastUpdated {
            let distance = lastUpdated.distance(to: Date.now)
            let seconds = Int(distance.rounded())
            
            if seconds < refreshSeconds {
                return
            }
        }
        lastUpdated = Date.now
        repository.read(limit: historyLimit)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.historyRelay.accept(elements)
                }
            )
            .disposed(by: disposeBag)
    }
    
    public func requestFarmingList() {
        farmingRepository.read(limit: 7)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.farmingRelay.accept(elements)
                }
            )
            .disposed(by: disposeBag)
    }
    
    public func requestRemoveAll() -> Single<Void> {
        return repository.removeAll()
    }
    
}
