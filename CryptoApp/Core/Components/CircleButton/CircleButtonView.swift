//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/20/25.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName : String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle()
                    .foregroundColor(.background)
            )
            .shadow(color:.accent.opacity(0.25) , radius: 10)
            .padding()
    }
}

#Preview {
    CircleButtonView(iconName: "info")
}
