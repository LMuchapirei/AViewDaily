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
        GeometryReader {
            let size = $0.size
            content
                .frame(width: size.width,height: size.height)
            
        }
    }
}
enum LockType: String  {
    case biometric = "Bio Metric Auth"
    case number = "Custom Number Lock"
    case both = "First preference will be biometric, and if it's not available, it will go for number lock"


}


struct TempView: View {
    var body: some View {
        LockView(lockType: .both, lockPin: "0408", isEnabled: true) {
            VStack(spacing:15){
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("Hello World")
            }
        }
    }
}
#Preview {
    TempView()
}
