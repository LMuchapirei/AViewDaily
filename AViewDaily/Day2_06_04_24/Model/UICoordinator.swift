//
//  UICoordinator.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 7/5/2024.
//

import SwiftUI


@Observable
class UICoordinator {
    /// Shared View Properties between Home and Detail View
    /*
     1. I'll extract the SwiftUI scrollview and save it here to take screenshot of the visible region for animation purposes
     2. Rect will be used to save the tapped post's View Rect for scaling calculations.
     */
    var scrollView: UIScrollView = .init(frame: .zero)
    var rect: CGRect = .zero
    var selectedItem: Item?
    var animationLayer: UIImage?
    var animateView: Bool = false
    var hideLayer: Bool = false
    /// Root View Properties
    var hideRootView: Bool = false
    /// Detail View Props
    var headerOffset: CGFloat = .zero
    
    
    func createVisibleAreaSnapshot(){
        let renderer = UIGraphicsImageRenderer(size: scrollView.bounds.size)
        /// Capture a screenshot of the scrollview's visible region, not the complete scroll content
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: -scrollView.contentOffset.x, y: scrollView.contentOffset.y)
            scrollView.layer.render(in: ctx.cgContext)
        }
        animationLayer = image
    }
}


/// Extract the UIKit ScrollView from the SwiftUI ScrollView 
struct ScrollViewExtractor: UIViewRepresentable {
    var result: (UIScrollView)-> ()
    func makeUIView(context: Context) ->  UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            if let scrollView = view.superview?.superview?.superview as? UIScrollView {
                result(scrollView)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}


