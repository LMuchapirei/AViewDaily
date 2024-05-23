//
//  NewTransaction.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 15/5/2024.
//

import SwiftUI

struct NewTransaction: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment:.leading,spacing: 15){
            Button(action:{
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            }
            .hSpacing(.leading)
            .padding([.top,.horizontal],5)
            
            VStack(alignment: .leading,spacing: 8, content: {
                Divider()
                    .padding(.horizontal,100)
                Text("Add New Transaction")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .padding(.horizontal,80)
                    .padding(.vertical,10)
                
                    ForEach(TransactionType.allCases,id:\.self){ item in
                        VStack {
                            HStack {
                                item.leadingIcon
                                Text(item.rawValue)
                                Spacer()
                                Image(systemName: "arrow.right")
                            }
                            Divider()
                        }
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        
                    }

            })
            .padding(.top,5)

        }
    }
}

#Preview {
    ContentView()
}
