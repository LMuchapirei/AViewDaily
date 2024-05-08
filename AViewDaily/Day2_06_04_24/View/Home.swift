//
//  Home.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 7/5/2024.
//

import SwiftUI

struct Home: View {
    var coordinator: UICoordinator = .init()
    @State private var posts: [Item] = sampleImages
    var body: some View {
        ScrollView(.vertical){
            LazyVStack(alignment:.leading,spacing:10){
                Text("Welcome Back!")
                    .font(.largeTitle.bold())
                    .padding(.vertical,10)
                
                /// Grid Image View
                LazyVGrid(columns: Array(repeating:GridItem(spacing:10),count:2),spacing: 10){
                    ForEach(posts){ post in
                        PostCardView(post)
                        
                    }
                }
                
            }
            .padding(15)
            .background(ScrollViewExtractor{
                coordinator.scrollView = $0
            })
           }
        .opacity(coordinator.hideRootView ? 0 : 1)
           .overlay {
            Detail()
                .environment(coordinator)

        }
    }
    
    //// Post Card View
    @ViewBuilder
    func PostCardView(_ post: Item)-> some View {
        GeometryReader {
            let frame = $0.frame(in: .global)
            ImageView(post: post)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    coordinator.selectedItem = post
                    /// Storing View's Rect
                    coordinator.rect = frame
                    /// Generating ScrollView's visible area Snapshot
                    coordinator.createVisibleAreaSnapshot()
                    coordinator.hideRootView = true
                    /// Animating View
                    withAnimation(.easeInOut(duration: 0.3),completionCriteria:.removed){
                        coordinator.animateView = true
                    } completion: {
                        coordinator.hideLayer = true
                        /// Once the detail view expands, l will hide the animation layer and enable detail view interaction, this will be reversed when the closing animation begins
                    }
                }
        }
        .frame(height: 180)
    }
}

#Preview {
    ContentView()
}


////  Note whats the difference between .background(.rect(cornerRadius:10))
