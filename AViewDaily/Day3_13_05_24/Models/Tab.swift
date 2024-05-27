//
//  Tab.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 13/5/2024.
//

import SwiftUI

enum Tab: String {
    case home =  "Home"
    case transactions =   "Transactions"
    case reports =   "Reports"
    case manage = "Manage"
 
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .home:
            Image(systemName: "house")
            Text(self.rawValue)
        case .transactions:
            Image(systemName: "arrow.left.arrow.right")
            Text(self.rawValue)
        case .reports:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .manage:
            Image(systemName: "line.3.horizontal")
            Text(self.rawValue)
        }
    }
}
