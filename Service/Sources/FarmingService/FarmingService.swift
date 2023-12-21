//
//  FarmingService.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation
import RxSwift
import BaseService

public enum FarmingServiceError: Error {
    case emptyElement
}

public protocol FarmingServiceInterface: AnyObject {
    func read() -> Single<FarmingElement?>
}

public final class FarmingService: FarmingServiceInterface {
    
    private let repository: FarmingRepositoryInterface
    private let calendar: CSCalendarInterface
    
    public init(
        repository: FarmingRepositoryInterface,
        calendar: CSCalendarInterface
    ) {
        self.repository = repository
        self.calendar = calendar
    }
    
    public func read() -> Single<FarmingElement?> {
        do {
            let date = try calendar.currentDate()
            return repository.readOne(date: date)
        } catch {
            return .error(error)
        }
    }
    
}
