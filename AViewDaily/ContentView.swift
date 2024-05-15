//
//  ContentView.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 3/5/2024.
//

import SwiftUI

struct ContentView: View {
    /// Active Tab
    @State private var activeTab: Tab = .home
    var body: some View {
        /// Preview for day 2 build
        //        NavigationStack {
        //             Home()
        //                .toolbar(.hidden,for:.navigationBar)
        //        }
        
        /// Preview for  day 3 build
        //        LandingPage()
        TabView(selection:$activeTab) {
            HomePageD3()
                .tag(Tab.home)
                .tabItem {
                    Tab.home.tabContent
                }
            TransactionsView()
                .tag(Tab.transactions)
                .tabItem {
                    Tab.transactions.tabContent
                }
            Text(Tab.reports.rawValue)
                .tag(Tab.reports)
                .tabItem {
                    Tab.reports.tabContent
                }
            Text(Tab.manage.rawValue)
                .tag(Tab.manage)
                .tabItem {
                    Tab.manage.tabContent
                }
        }
    }
}

#Preview {
    ContentView()
}

//// Note : When using navigation stack we must hide the default navigation bar
