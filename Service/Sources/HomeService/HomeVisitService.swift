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
    
    func requestVisitHistory() -> Single<[ContentElement]>
    func requestRemoveAll() -> Single<Void>
    
}
