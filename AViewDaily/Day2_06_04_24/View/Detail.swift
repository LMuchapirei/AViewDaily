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
                                .offsetY { offset in
                                    coordinator.headerOffset =
                                    max(min(-offset,detailHeight),0)
                                    //// limit the headerview not to go all the way to the top, to leave space for the scroll content
                                }
                        }
                }
                .contentMargins(.top,detailHeight,for:.scrollIndicators)
                .background {
                    Rectangle()
                        .fill(.background)
                        .padding(.top,detailHeight)
                }
                .animation(.easeInOut(duration: 0.3).speed(1.5)){
                    $0
                        .offset(y:animateView ? 0: scrollContentHeight)
                        .opacity(animateView ? 1 : 0)
                }
                
                /// Hero Kinda View
                ImageView(post: post)
                    .allowsHitTesting(false)
                    .frame(width: animateView ? size.width : rect.width,height: animateView ? rect.height * scale : rect.height
                    )
                    .clipShape(.rect(cornerRadius: animateView ? 0: 10))
                    .offset(x:animateView ? 0 : rect.minX,y:animateView ? 0: rect.minY)
                    .offset(y: -coordinator.headerOffset)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}


//// Continue @12:30
