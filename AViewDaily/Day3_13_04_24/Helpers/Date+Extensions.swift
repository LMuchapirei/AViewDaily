//
//  Date+Extensions.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 13/5/2024.
//

import SwiftUI


extension Date  {
    
    // custom date format
    func format(_ format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// confirm if the current date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Creating Next Week, based on the Last Current Week's Date
    func createNextWeek() -> [WeekDay]{
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day,value: 1, to: startOfLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    /// Creating Prev Week, based on the First Current Week's Date
    func createPreviousWeek() -> [WeekDay]{
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day,value: -1, to: startOfFirstDate) else {
            return []
        }
        return fetchWeek(previousDate)
    }

    func fetchWeek(_ date: Date = .init()) -> [WeekDay]{
        let calendar = Calendar.current
        let startOffDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay]  = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOffDate)
        guard let startOfWeek = weekForDate?.start else {
            return []
        }
        /// Iterating to get the Full Week
        (0..<7).forEach{ index in
            if let weekDay = calendar.date(byAdding: .day,value:index, to: startOfWeek){
                week.append(.init(date: weekDay))
            }
        }
        return week
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
