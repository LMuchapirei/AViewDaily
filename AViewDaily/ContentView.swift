//
//  ContentView.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 3/5/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /// Preview for day 2 build
        NavigationStack {
             Home()
                .toolbar(.hidden,for:.navigationBar)
        }
    }
}

#Preview {
    ContentView()
}

//// Note : When using navigation stack we must hide the default navigation bar
