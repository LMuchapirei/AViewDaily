//
//  HomePageD3.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 15/5/2024.
//

import SwiftUI

struct HomePageD3: View {
    @State private var createTransaction: Bool = false
    let total : Double = sampleTransactions.reduce(0.0) { $0 + $1.amount }
    var body: some View {
        VStack {
            HStack (alignment:.top){
                VStack(alignment:.leading){
                    HStack {
                        Text("Today's Total")
                        Image(systemName: "arrow.up.and.down")
                    }
                    Text(Decimal(total).formatted(.currency(code: "USD")))
                        .font(.largeTitle)
                        .bold()
                        .padding(.vertical,8)
                }
                Spacer()
                Circle()
                    .frame(width: 40,height: 40)
            }
            .padding(.horizontal,10)
            
            HStack {
                createTransactionStats(title: "Inflow", amount: "$659",type:.inflow)
                createTransactionStats(title: "Outflow", amount: "$659",type: .outflow)
            }
            
            HStack{
                Text("Add New Transaction")
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
                    .bold()
            }
            .foregroundColor(.white)
            .padding()
            .background(.blue,in:.rect(cornerRadius: 8))
            .padding()
            .onTapGesture {
                createTransaction.toggle()
            }
            
            Divider()
            
            HStack {
                Text("Recent Transaction")
                    .bold()
                Spacer()
                HStack {
                    Text("View All")
                        .bold()
                    Image(systemName: "arrow.right")
                        .bold()
                }
                .foregroundStyle(.blue)
            }
            .padding()
            ScrollView {
                ForEach(0 ..< 3){ index in
                    TransactionItem(transaction: sampleTransactions[index])
                }
            }
        }
        .sheet(isPresented: $createTransaction){
            NewTransaction()
                .presentationDetents([.height(UIScreen.main.bounds.size.height*0.55)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.white)
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
