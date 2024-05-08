//
//  View+Extensions.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 8/5/2024.
//

import SwiftUI


extension View {
    /// SafeArea
    var safeArea: UIEdgeInsets {
        if let safeArea = (
            UIApplication.shared.connectedScenes.first as? UIWindowScene
            )?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    @ViewBuilder
    func offsetY(result: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minY = $0.frame(in: .scrollView(axis:.vertical)).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self,perform: { value in
                            result(value)
                        })
                }
            }
    }
}


////  Preference Keys
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
