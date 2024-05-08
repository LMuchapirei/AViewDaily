//
//  Detail.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 7/5/2024.
//

import SwiftUI

struct Detail: View {
    @Environment(UICoordinator.self) private var coordinator
    var body: some View {
        GeometryReader {
            let size = $0.size
            let animateView = coordinator.animateView
            let hideView = coordinator.hideRootView
            let hideLayer = coordinator.hideLayer
            let rect = coordinator.rect
            let anchorX = (rect.minX / size.width) > 0.5 ? 1.0 : 0.0
            let scale = size.width / rect.width /// ( this value will be scaled to meet the screen's whole width)
            /// 15 - Horizontal Padding
            let offsetX = animateView ? (anchorX < 0.5 ? 15 : -15) * scale : 0
            let offsetY = animateView ? -rect.minY * scale : 0
            let detailHeight: CGFloat = rect.height * scale
            let scrollContentHeight: CGFloat = size.height - detailHeight
            if let image = coordinator.animationLayer,let post = coordinator.selectedItem {
                Image(uiImage: image)
                    .scaleEffect(animateView ? scale : 1,anchor: .init(x:anchorX, y: 0))
                    .offset(x:offsetX,y: offsetY)
                    .opacity(animateView ? 0 : 1)
                    .onTapGesture {
                        coordinator.animationLayer = nil
                        coordinator.hideRootView = false
                        coordinator.animateView = false
                    }
                
                ScrollView (.vertical){
                    /// YOUR SCROLL CONTENT
                    RandomContent()
                        .safeAreaInset(edge: .top,spacing: 0) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: detailHeight)
                        }
                }
                
                /// Hero Kinda View
                ImageView(post: post)
                    .allowsHitTesting(false)
                    .frame(width: animateView ? size.width : rect.width,height: animateView ? rect.height * scale : rect.height
                    )
                    .clipShape(.rect(cornerRadius: animateView ? 0: 10))
                    .offset(x:animateView ? 0 : rect.minX,y:animateView ? 0: rect.minY)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}


//// Continue @12:30
