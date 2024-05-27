//
//  Manage.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 23/5/2024.
//

import SwiftUI

struct Manage: View {
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section("App Lock"){
                    Toggle("Enable App Lock",isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                        Toggle("Lock When App Goes Background",isOn: $lockWhenAppGoesBackground)
                    }
                }
            }
        }.navigationTitle("Manage Account")
    }
}

#Preview {
    Manage()
}
