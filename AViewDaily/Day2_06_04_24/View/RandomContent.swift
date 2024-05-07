//
//  RandomContent.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 7/5/2024.
//

import SwiftUI

struct RandomContent: View {
    var body: some View {
        LazyVStack(spacing:15){
            DummySection(title:"Social Media")
            
            DummySection(title:"Sales",isLong:true)
            
            ImageView("Pic 1")
            
            DummySection(title:"Business",isLong:true)
            
            DummySection(title:"Promotion",isLong:true)
            
            ImageView("Pic 2")
            
            DummySection(title:"YouTube")
            
            DummySection(title:"Twitter (X)")
            
            DummySection(title:"Marketing Campaign",isLong:true)
            
            ImageView("Pic 3")
            
            DummySection(title:"YouTube",isLong:true)
        }
    }
    
    @ViewBuilder
    func DummySection(title: String,isLong: Bool = false) -> some View {
        VStack(alignment:.leading,spacing:8){
            Text(title)
                .font(.title.bold())
            Text("Lorem ipsum, dolor sit amet consectetur adipisicing elit. Voluptatem vero ducimus qui et distinctio! Itaque repellat minus architecto accusantium, quam sunt quas commodi quod officia pariatur rerum autem dolorum eveniet tempore ratione minima, unde \(isLong ?"facere at molestias vel, nisi eos quis? Aspernatur asperiores accusamus nobis ipsa. Explicabo, optio sequi placeat vitae, repellat corporis adipisci molestias quo numquam voluptatum impedit.":"")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    @ViewBuilder
    func ImageView(_ image: String) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width,height: size.height)
                .clipped()
        }
        .frame(height: 400)
    }
}

#Preview {
    RandomContent()
}
