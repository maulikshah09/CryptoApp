//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/17/25.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
