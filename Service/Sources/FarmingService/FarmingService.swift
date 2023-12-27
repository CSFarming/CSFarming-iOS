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
    case earlyExit
}

public protocol FarmingServiceInterface: AnyObject {
    func read() -> Single<FarmingElement?>
    func read(daysAgo value: Int) -> Single<[FarmingElement]>
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
    
    public func read(daysAgo value: Int) -> Single<[FarmingElement]> {
        do {
            let minimumDate = try calendar.daysAgo(value: value)
            return repository.read(minimumDate: minimumDate)
                .map { [weak self] elements in
                    guard let self else { throw FarmingServiceError.earlyExit }
                    return try withDefaultElement(with: elements, daysAgo: value)
                }
        } catch {
            return .error(error)
        }
    }
    
    private func withDefaultElement(with elements: [FarmingElement], daysAgo value: Int) throws -> [FarmingElement] {
        let dates = try (0..<value).map { try calendar.daysAgo(value: $0) }
        var newElements: [FarmingElement] = dates.map { date in
            return .init(activityScore: 0, date: date, problems: [])
        }
        elements.forEach { element in
            if let index = newElements.firstIndex(where: { $0.date == element.date }) {
                newElements[index] = element
            }
        }
        return newElements
    }
    
}
