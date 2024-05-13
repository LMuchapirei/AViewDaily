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
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    
    var body: some View {
        VStack{
            TabView(selection: $currentWeekIndex){
                ForEach(weekSlider.indices,id:\.self){ index in
                    let week = weekSlider[index]
                    DateSlider(week)
                        .padding(.horizontal,15)
                        .tag(index)
                    
                }
            }
            .padding(.horizontal,-15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
            HStack{
                Text("All Transactions")
                Image(systemName: "arrow.up.arrow.down.square")
                Spacer()
                Text("$6250.50")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.white)
            .background(
                .blue
            )
            ScrollView(.vertical){
                TransactionView()
            }.scrollIndicators(.hidden)
        }
        .onChange(of: currentWeekIndex){
            newValue in
            //  create when it reaches first/last page
            if newValue==0 || newValue == (weekSlider.count-1){
                createWeek = true
            }
        }
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        })
    }
    
    @ViewBuilder
    func TransactionView()-> some View {
        VStack(alignment:.leading,spacing: 10){
            ForEach(0 ..< 10){ _ in
                VStack {
                    HStack {
                        VStack(alignment:.leading){
                            Text("Test Account")
                            Text("Card : 8:00 PM")
                        }
                        Spacer()
                        Text("$125.00")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    
                    Divider()
                        .padding(.horizontal,12)
                }
                .padding(.horizontal,12)
            }
        }
    }
    
    @ViewBuilder
    func DateSlider(_ week: [Date.WeekDay])-> some View {
        HStack(spacing:0){
            ForEach(week){ day in
                VStack(spacing:8){
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary) // API available in iOS17
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .blue:.gray)
                        .frame(width:35,height: 35)
                    
                    
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .blue:.gray)
                    
                    if isSameDate(day.date, currentDate){
                        Triangle()
                            .fill(.blue)
                            .frame(width:20,height:10)
                    }

                        
                }
                .hSpacing(.center)
                .onTapGesture {
                    /// Update the current date
                    withAnimation(.easeInOut){ // some jankiness on the animations need some fix
                        currentDate = day.date
                    }
                }
                
                
            }
        }
        .background {
        GeometryReader {
            let minX = $0.frame(in:.global).minX
            
            Color.clear
                .preference(key: OffsetKey.self,value: minX)
                .onPreferenceChange(OffsetKey.self){ value in
                    /// When the Offset reaches 15 and if the createWeek is toggled then simply generate the next set of week
                    if value.rounded() == 15 && createWeek {
                        paginateWeek()
                        createWeek = false
                    }
                }
        }
      }
    }
    
    func paginateWeek(){
        /// SafeCheck
        if weekSlider.indices.contains(currentWeekIndex){
            if let firstDate = weekSlider[currentWeekIndex].first?.date,currentWeekIndex==0 {
                /// Inserting new week at the 0th Index and Removing Last Array Item
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            if let lastDate =
                weekSlider[currentWeekIndex].last?.date,currentWeekIndex==(weekSlider.count-1){
                // Appending new week at the end,removing the first index
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count-2
            }

        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}



#Preview {
    LandingPage()
}


// use this same style as the image
//                        .background(content:{
//                            if isSameDate(day.date, currentDate){
//                                Circle()
//                                    .fill(.blue)
//                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
//                            }
//                            if day.date.isToday {
//                                Circle()
//                                    .fill(.cyan)
//                                    .frame(width: 5,height: 5)
//                                    .vSPacing(.bottom)
//                                    .offset(y: 12)
//                            }
//
//                        })
