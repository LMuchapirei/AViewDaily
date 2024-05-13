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
}
