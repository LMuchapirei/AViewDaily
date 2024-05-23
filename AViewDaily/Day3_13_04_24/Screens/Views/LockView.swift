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
            
            if isEnabled && !isUnlocked {
                ZStack {
                    Rectangle()
                        .fill(.black.opacity(0.8))
                        .ignoresSafeArea()
                    
                    if (lockType == .both && !noBiometricAccess) || lockType == .biometric {
                        Group {
                            if noBiometricAccess {
                                Text("Enable biometric authentication in Settings to unlock the view.")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)
                                    .padding(50)
                            } else {
                                VStack(spacing: 12){
                                    VStack(spacing:6){
                                        Image(systemName: "lock")
                                            .font(.largeTitle)
                                            .foregroundStyle(.white)
                                        Text("Tap to Unlock")
                                            .font(.caption2)
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width:100,height: 100)
                                    .background(.ultraThinMaterial,in:.rect(cornerRadius: 10))
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        //                                    unlockView()
                                    }
                                    
                                    if lockType == .both {
                                        Text("Enter Pin")
                                            .frame(width: 100,height: 40)
                                            .background(.ultraThinMaterial,in: .rect(cornerRadius: 10))
                                            .contentShape(.rect)
                                            .foregroundStyle(.white)
                                            .onTapGesture {
                                                noBiometricAccess = true
                                            }
                                    }
                                }
                            }
                        }
                    } else {
                        NumberPadPinView()
                    }
                }
                .environment(\.colorScheme,.dark)
                .transition(.offset(y:size.height + 100))
            }
        }
    }
    
    /// getter to determine if device supports biometrics
    private var isBiometricAvailable : Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    @ViewBuilder
    func NumberPadPinView () -> some View {
        VStack(spacing:15){
            Text("Enter Pin")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
                .overlay (alignment: .leading) {
                    if lockType == .both && isBiometricAvailable {
                        Button(action: {
                            pin = ""
                            noBiometricAccess = false
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .contentShape(.rect)
                        }
                        .tint(.white)
                        .padding(.leading)
                    }
                }
            
            // Adding Wiggling Animation for Wrong pin the keyframe animator
            
            HStack(spacing:10){
                ForEach(0..<4,id:\.self){ index in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50,height: 55)
                        .overlay {
                            if pin.count > index {
                                let index = pin.index(pin.startIndex,offsetBy: index)
                                let string = String(pin[index])
                                
                                Text(string)
                                    .font(.title.bold())
                                    .foregroundStyle(.black)
                            }
                        }
                    
                }
            }
            .keyframeAnimator(initialValue: CGFloat.zero,trigger:animateField,
                              content:{ content,value in
                content.offset(x:value)
            },keyframes: { _ in
                    KeyframeTrack {
                        CubicKeyframe(30,duration: 0.07)
                        CubicKeyframe(-30,duration: 0.07)
                        CubicKeyframe(20,duration: 0.07)
                        CubicKeyframe(-20,duration: 0.07)
                        CubicKeyframe(0,duration: 0.07)
                    }
                }
          )
            .padding(.top,15)
            .overlay(alignment:.bottomTrailing){
                Button("Forgot Pin?",action: forgotPin)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .offset(y:40)
            }
            .frame(maxHeight: .infinity)
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
