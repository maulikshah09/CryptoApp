//
//  HomeView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/20/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio  = false
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                HomeHeader
                
                List{
                    ForEach(0..<10){ coin in
                        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumn:showPortfolio )
                    }
                 }
                .listStyle(.plain)
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
   private var HomeHeader : some View{
        HStack{
             CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                
                .onTapGesture {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .navigationBarHidden(true)
    }
}
