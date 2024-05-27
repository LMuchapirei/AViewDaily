//
//  ScrollableTabs.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 27/5/2024.
//

import SwiftUI

struct ScrollableTabs: View {
    @State private var activeTab: DummyTab = .home
    var offsetObserver = PageOffsetObserver()
    var body: some View {
        VStack(spacing:15) {
            TabView(selection:$activeTab){
                DummyTab.home.color
                    .tag(DummyTab.home)
                    .background {
                        if !offsetObserver.isObserving {
                            FindCollectionView {
                                offsetObserver.collectionView = $0
                                offsetObserver.observe()
                            }

                        }
                    }
                
                DummyTab.charts.color
                    .tag(DummyTab.charts)
                
                DummyTab.calls.color
                    .tag(DummyTab.calls)
                
                DummyTab.settings.color
                    .tag(DummyTab.settings)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay {
                Text("\(offsetObserver.offset)")
            }
        }
    }
}

#Preview {
    ScrollableTabs()
}


/// SwiftUI Page TabView is built on top of the UIKit's UICollectionView which in turn provides the content offset so we can extract the UIKit's UICollectionView from the SwiftUI Page Tab View
///
///


/// on iOS 16 simply change this to conform to ObservableObject

@Observable
class PageOffsetObserver: NSObject {
    var collectionView: UICollectionView?
    var offset: CGFloat = 0
    private (set) var isObserving: Bool = false
    
    deinit {
        remove()
    }
    func observe(){
        guard !isObserving else { return }
        collectionView?.addObserver(self, forKeyPath: "contentOffset", context: nil)
        isObserving = true
    }
    
    func remove(){
        isObserving = false
        collectionView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentOffset" else { return }
        if let contextOffset = (object as? UICollectionView)?.contentOffset {
            offset = contextOffset.x
        }
    }
}

struct FindCollectionView: UIViewRepresentable {
    var result: (UICollectionView) -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            if let collectionView = view.collectionSuperView {
                result(collectionView)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

/// how to find the view we want by traversing the superview
///

extension UIView {
    var collectionSuperView: UICollectionView? {
        if let collectionView = superview as? UICollectionView {
            return collectionView
        }
        return superview?.collectionSuperView
    }
}
