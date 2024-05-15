//
//  HomePageD3.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 15/5/2024.
//

import SwiftUI

struct HomePageD3: View {
    let total : Double = sampleTransactions.reduce(0.0) { $0 + $1.amount }
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading){
                    HStack {
                        Text("Today's Total")
                        Image(systemName: "arrow.up.and.down")
                    }
                    Text(Decimal(total).formatted(.currency(code: "USD")))
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
                Circle()
                    .frame(width: 60,height: 60)
            }
            .padding(.horizontal,10)
            
            HStack {
                createTransactionStats(title: "Inflow", amount: "$659",type:.inflow)
                createTransactionStats(title: "Outflow", amount: "$659",type: .outflow)
            }
            
            HStack{
                Text("Add New Transaction")
                
            }

        }
    }
    
    @ViewBuilder
    func createTransactionStats(title: String,amount: String,type: Inflow )-> some View  {
        HStack (alignment:.top) {
            VStack(alignment:.leading) {
                Text("\(title)")
                    .foregroundStyle(type.textColor)
                
                Text(amount)
                    .font(.title)
                    .bold()
                    .padding(.vertical)
            }
            Spacer()
            type.imageToDisplay
        }
        .frame(width: UIScreen.main.bounds.size.width/3,height: 100)
        .padding()
        .background(type.foregroundColor,in:.rect(cornerRadius: 12))
    }
    
}

enum Inflow {
    case inflow
    case outflow
    
    @ViewBuilder
    var imageToDisplay: some View {
        switch self {
        case .inflow:
            Image(systemName: "arrow.down.left")
                .foregroundStyle(.green)
        case .outflow:
            Image(systemName: "arrow.up.right")
                .foregroundStyle(.red)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .inflow:
            return .green.opacity(0.2)
        case .outflow:
            return .red.opacity(0.2)
        }
    }
    
    var textColor: Color {
        switch self {
        case .inflow:
            return .green
        case .outflow:
            return .red
        }
    }

}

#Preview {
    ContentView()
}
