//
//  NiceBottomSheet.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 4/7/2024.
//

import SwiftUI

struct NiceBottomSheet: View {
    @State private var showSheet = false
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    showSheet.toggle()
            }
        }.sheet(isPresented: $showSheet, content: {
            TermsModalView()
                .presentationDetents([.height(400),.medium,.large])
                .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 20))
        })
    }
}

struct TermsModalView: View {
    @State private var termsOption1 = false
    @State private var termsOption2 = false
    
    @State private var errorState = false
    @State private var complete = false
    @State private var toggleError = false
    @State private var showProgress = false
    var body: some View {
        VStack(alignment:.leading,spacing: 10) {
            Spacer()
            Text("Create Account")
                .font(.largeTitle)
                .bold()
                .padding(.top,10)
            Text("You must agree to our terms to create a Candle account.")
            
            VStack (spacing:30) {
                CheckboxView(isChecked: $termsOption1, label: "I have read and agree to Candle's Tersm of Service and Privacy Policy")
                CheckboxView(isChecked: $termsOption2, label: "I understand Candle is not a bank, broker-dealer or investment adviser.")
            }
            .padding([.horizontal],30)
            Spacer()
            HStack {
                Spacer()
                if !errorState {
                    getButton(completionStatus: complete)
                    
                } else {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Spacer()
                        Text("Please Agree")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .keyframeAnimator(initialValue: CGFloat.zero,trigger:toggleError,
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
                    .padding([.horizontal],50)
                    .padding([.vertical],15)
                    .foregroundColor(.white.opacity(0.8))
                    .background(.red,in:.rect(cornerRadius: 30))
                    .onTapGesture {
                        errorState = false
                        toggleError = false
                    }

                }
                Spacer()
                
            }.onTapGesture {
                if !termsOption1  || !termsOption1 {
                    withAnimation {
                        errorState.toggle()
                    }
                }
            }
                
        }
        .padding(.horizontal,30)
        
    }
    
    @ViewBuilder
    func getButton(completionStatus: Bool) -> some View {
        if showProgress {
            HStack {
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.0,anchor: .center)
                Spacer()
                Text("Creating...")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding([.horizontal],50)
            .padding([.vertical],15)
            .foregroundColor(.white.opacity(0.8))
            .background(.black,in:.rect(cornerRadius: 30))

        } else {
            if !completionStatus {
                actionButton(icon: nil, label: "Create Account", completionStatus: completionStatus)
                    .onTapGesture {
                        print("Create account tapped")
                        if termsOption1 && termsOption2 {
                            showProgress = true
                            DispatchQueue.main.asyncAfter(
                                deadline:.now() + 2
                            ){
                                showProgress = false
                                complete.toggle()
                            }
                           
                        } else {
                            errorState.toggle()
                            DispatchQueue.main.asyncAfter(
                                deadline:.now() + 1
                            ){
                                toggleError.toggle()
                            }
                        }
                    }
            } else {
                actionButton(icon: "checkmark", label: "Account Created", completionStatus: completionStatus)
                    .onTapGesture {
                        print("Account now created")
                    }
                
            }

        }
    }
    
    @ViewBuilder
    func actionButton(icon: String?,label: String,completionStatus: Bool)-> some View {
        HStack {
            if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(.white)
            }
            if completionStatus {
                Spacer()
            }
            Text(label)
                .font(.title2)
                .bold()
        }
        .padding([.horizontal],50)
        .padding([.vertical],15)
        .foregroundColor(.white.opacity(0.8))
        .background(completionStatus ? .green : .black,in:.rect(cornerRadius: 30))
    }
}



struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CheckboxView : View {
    @Binding var isChecked: Bool
    var label: String
    
    var body: some View {
        HStack {
            Button(action: {
                self.isChecked.toggle()
            }) {
                HStack {
                    Image(systemName: isChecked ? "checkmark.square" : "square")
                        .foregroundColor(isChecked ? .green : .gray)
                        .font(.title)
                    Spacer()
                    Text(label)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    NiceBottomSheet()
}
