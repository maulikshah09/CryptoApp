//
//  ContentView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 40){
                Text("Accent color")
                    .foregroundStyle( Color.accent)
               
                Text("Secondary text color")
                    .foregroundStyle( Color.secondaryText)
               
                Text("Red color")
                    .foregroundStyle(Color.txtRed)
               
               
                Text("Green color")
                    .foregroundStyle( Color.txtGreen)
            }
        }
    }
}

#Preview {
    ContentView()
}
