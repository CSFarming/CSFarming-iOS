//
//  HomeVisitService.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import RxSwift
import BaseService

public protocol HomeVisitServiceInterface: AnyObject {
    
    var currentHistory: Observable<[ContentElement]> { get }
    func requestVisitHistory()
    func requestRemoveAll() -> Single<Void>
    
}
