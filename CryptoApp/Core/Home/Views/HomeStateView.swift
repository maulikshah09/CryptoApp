//
//  HomeStateView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import SwiftUI

struct HomeStateView: View {
     
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics){ stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStateView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
