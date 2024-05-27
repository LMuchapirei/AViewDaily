//
//  ScrollableTabs.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 27/5/2024.
//

import SwiftUI

struct ScrollableTabs: View {
    @State private var activeTab: DummyTab = .home
    
    var body: some View {
        VStack(spacing:15) {
            TabView(selection:$activeTab){
                DummyTab.home.color
                    .tag(DummyTab.home)
                
                DummyTab.charts.color
                    .tag(DummyTab.charts)
                
                DummyTab.calls.color
                    .tag(DummyTab.calls)
                
                DummyTab.settings.color
                    .tag(DummyTab.settings)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    ScrollableTabs()
}


/// SwiftUI Page TabView is built on top of the UIKit's UICollectionView which in turn provides the content offset so we can extract the UIKit's UICollectionView from the SwiftUI Page Tab View
