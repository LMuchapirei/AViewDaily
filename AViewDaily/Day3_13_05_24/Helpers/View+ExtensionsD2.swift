//
//  View+Extensions.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 13/5/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity,alignment: alignment)
    }
    
    @ViewBuilder
    func vSPacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity,alignment: alignment)
    }
    
    /// compare two date if they are equal
    func isSameDate(_ date1: Date,_ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
