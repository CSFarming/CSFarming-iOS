//
//  Date+.swift
//
//
//  Created by 홍성준 on 12/28/23.
//

import Foundation

public extension Date {
    
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    func isSameDay(date: Date) -> Bool {
        return year == date.year && month == date.month && day == date.day
    }
    
    func clipDate() -> Date? {
        return Calendar.current.date(from: .init(
            year: year,
            month: month, 
            day: day
        ))
    }
    
    func daysAgo(value: Int) -> Date? {
        return Calendar.current.date(
            byAdding: .day,
            value: -value,
            to: self
        )
    }
    
}
