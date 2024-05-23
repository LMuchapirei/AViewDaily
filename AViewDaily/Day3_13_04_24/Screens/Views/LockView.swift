//
//  LockView.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 23/5/2024.
//

import SwiftUI
import LocalAuthentication

struct LockView<Content: View>: View {
    /// Lock values
    var lockType: LockType
    var lockPin: String
    var isEnabled: Bool
    var lockWhenAppGoesBackground: Bool = true
    @ViewBuilder var content: Content
    var forgotPin: () -> () = {}
    
    /// View Properties
    @State private var pin: String = ""
    @State private var animateField: Bool = false
    @State private var isUnlocked: Bool = false
    @State private var noBiometricAccess: Bool = false
    
    // Lock Context
    let context = LAContext()
    @Environment(\.scenePhase) private var phase
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LockView()
}
