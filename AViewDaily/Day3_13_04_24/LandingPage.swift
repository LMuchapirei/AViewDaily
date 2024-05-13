//
//  LandingPage.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 13/5/2024.
//

import SwiftUI

struct LandingPage: View {
    @State private var currentDate: Date = .init()
    @Namespace private var animation
    @State private var weekSlider: [[Date.WeekDay]] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    func DateSlider(_ week: [Date.WeekDay])-> some View {
        HStack(spacing:0){
            ForEach(week){ day in
                VStack(spacing:8){
                    
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary) // API available in iOS17
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white:.gray)
                        .frame(width:35,height: 35)
                        .background(content:{
                            if isSameDate(day.date, currentDate){
                                Circle()
                                    .fill(.blue)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            if day.date.isToday {
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 5,height: 5)
                                    .vSPacing(.bottom)
                                    .offset(y: 12)
                            }
                        
                        })
                }
                
            }
        }
    }
}

#Preview {
    LandingPage()
}
