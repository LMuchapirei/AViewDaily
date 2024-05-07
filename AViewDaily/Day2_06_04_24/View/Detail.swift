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
            
            let anchorX = (coordinator.rect.minX / size.width) > 0.5 ? 1.0 : 0.0
            let scale = coordinator.rect.width / size.width /// ( this value will be scaled to meet the screen's whole width)
            if let image = coordinator.animationLayer {
                Image(uiImage: image)
                    .scaleEffect(animateView ? scale : 1,anchor: .init(x: animateView ? anchorX : 1, y: 0))
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Detail()
}
