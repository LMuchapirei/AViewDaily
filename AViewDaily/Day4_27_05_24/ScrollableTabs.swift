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
            TabBarHeader(.gray)
                .overlay {
                    if let collectionViewBounds = offsetObserver.collectionView?.bounds {
                        GeometryReader {
                            let width = $0.size.width
                            let tabCount = CGFloat(DummyTab.allCases.count)
                            let capsuleWidth = width / tabCount
                            let progress = offsetObserver.offset / collectionViewBounds.width
                            
                            Capsule()
                                .frame(width: capsuleWidth)
                                .offset(x:progress * capsuleWidth)
                            
                            TabBarHeader(.white,.semibold)
                                .mask(alignment: .leading) {
                                   
                                }
                        }
                    }
                }
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
                .shadow(color:.black.opacity(0.2),radius: 5,x:5,y:5)
                .shadow(color:.black.opacity(0.05),radius: 5,x:-5,y:-5)
                .padding([.horizontal,.top],15)
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
//            .overlay {
//                Text("\(offsetObserver.offset)")
//            }
        }
    }
    
    @ViewBuilder
    func TabBarHeader(_ tint: Color,_ weight: Font.Weight = .regular) -> some View {
        HStack(spacing:0){
            ForEach(DummyTab.allCases,id: \.rawValue){ tab in
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(weight)
                    .foregroundStyle(tint)
                    .padding(.vertical,10)
                    .frame(maxWidth:.infinity)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy(duration:0.3,extraBounce: 0)) {
                            activeTab = tab
                        }
                    }
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
