//
//  Home.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 7/5/2024.
//

import SwiftUI

struct Home: View {
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
                print($0)
            })
        }
    }
    
    //// Post Card View
    @ViewBuilder
    func PostCardView(_ post: Item)-> some View {
        GeometryReader {
            let frame = $0.frame(in: .global)
            
            if let image = post.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width,height: frame.height)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .frame(height: 180)
    }
}

#Preview {
    ContentView()
}


////  Note whats the difference between .background(.rect(cornerRadius:10))
