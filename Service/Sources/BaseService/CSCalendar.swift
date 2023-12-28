//
//  CSCalendar.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation

public enum CSCalendarError: Error {
    case invalidDate
}

public protocol CSCalendarInterface: AnyObject {
    func currentDate() throws ->  Date
    func daysAgo(value: Int) throws -> Date
}

public final class CSCalendar: CSCalendarInterface {
    
    private let calendar: Calendar
    
    public init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
    
    public func currentDate() throws ->  Date {
        let year = calendar.component(.year, from: .now)
        let month = calendar.component(.month, from: .now)
        let day = calendar.component(.day, from: .now)
        
        guard let date = calendar.date(from: .init(year: year, month: month, day: day)) else {
            throw CSCalendarError.invalidDate
        }
        return date
    }
    
    public func daysAgo(value: Int) throws -> Date {
        do {
            let current = try currentDate()
            if let date = calendar.date(byAdding: .day, value: -value, to: current) {
                return date
            } else {
                throw CSCalendarError.invalidDate
            }
        } catch {
            throw error
        }
    }
    
}
