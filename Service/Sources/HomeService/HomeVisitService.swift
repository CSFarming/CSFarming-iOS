//
//  HomeVisitService.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import RxSwift
import BaseService
import FarmingService

public protocol HomeVisitServiceInterface: AnyObject {
    
    var currentHistory: Observable<[HomeElement]> { get }
    var farmingList: Observable<[FarmingElement]> { get }
    func requestVisitHistory()
    func requestFarmingList()
    func requestRemoveAll() -> Single<Void>
    
}
