//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import SwiftUI

struct StatisticView: View {
    
    let stat : StatisticModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPresentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                (stat.percentageChange ?? 0) >= 0 ? .txtGreen : .txtRed
            )
            .opacity(stat.percentageChange == nil ? 0.0: 1.0)
        } 
    }
}

#Preview {
    StatisticView(stat: StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 110.0))
}
