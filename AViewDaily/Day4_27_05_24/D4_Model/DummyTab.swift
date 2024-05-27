//
//  D4_Tab.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 27/5/2024.
//

import SwiftUI

enum DummyTab: String, CaseIterable {
    case home = "Home"
    case charts = "Charts"
    case calls = "Calls"
    case settings  = "Settings"
    
    var color: Color {
        switch self {
        case .home :
            return .red
        case .charts:
            return .blue
        case .calls:
            return .black
        case .settings:
            return .purple
        }
    }
}

