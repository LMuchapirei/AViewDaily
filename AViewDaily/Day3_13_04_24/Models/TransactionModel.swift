//
//  TransactionModel.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 15/5/2024.
//

import Foundation
import SwiftUI

struct TransactionModel : Identifiable, Equatable {
    let id: UUID = .init()
    let timeStamp: Date
    let transactionTitle: String
    let amount: Double
    let transactionType: TransactionType
    let description: String
    let flowType: FlowType
    let sourceAccount: String
    let destinationAccount: String
}

enum TransactionType : String{
    case card = "Cash"
    case bill = "Bill Payment"
    case transfer = "Funds Transfer"
    case cashDeposit = "Cash Deposit"
    case qr = "QR"
    
    @ViewBuilder
    var leadingIcon: some View {
        switch self {
        case .card:
            Image(systemName: "creditcard")
        case .bill:
            Image(systemName: "wallet.pass")
        case .transfer:
            Image(systemName: "arrow.left.arrow.right")
        case .cashDeposit:
            Image(systemName: "dollarsign.arrow.circlepath")
        case .qr:
            Image(systemName: "qrcode")
        }
    }
}

enum FlowType: String {
    case credit
    case debit
}


let sampleTransactions: [TransactionModel] = [
    TransactionModel(timeStamp: .now, transactionTitle: "Zesa Electricity", amount: 124, transactionType: .bill, description: "Outgoing Bill Payment to ZESA - Biller 101",flowType: .debit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "Mortgage Interest", amount: 1000, transactionType: .transfer, description: "Outgoing Transfer to Mortgate Account -1000193883939",flowType: .debit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "Salary", amount: 12494, transactionType: .transfer, description: "Incoming  Payment from FCorp -Main Pay",flowType: .credit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "Salary", amount: 2494, transactionType: .transfer, description: "Incoming  Payment from FCorp -Inflation Adjustment",flowType: .credit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "Salary", amount: 10494, transactionType: .transfer, description: "Incoming  Payment from FCorp -Bonus Payment",flowType: .credit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "401 Contribution", amount: 2494, transactionType: .bill, description: "Outgoing Transfer to SSAccount - 401 Match",flowType: .debit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "Medical Aid Settlement", amount: 494, transactionType: .bill, description: "Outgoing Bill Payment to Medical Enhance - Biller 104",flowType: .debit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "Salary", amount: 12494, transactionType: .bill, description: "Outgoing Bill Payment to ZESA - Biller 101",flowType: .credit,sourceAccount: "",destinationAccount: ""),
    TransactionModel(timeStamp: .now, transactionTitle: "KFC Divaris", amount: 12494, transactionType: .qr, description: "Outgoing QR Payment to ZESA - Biller 101",flowType: .credit,sourceAccount: "",destinationAccount: "")
]
