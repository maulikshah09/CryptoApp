//
//  HomeView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/20/25.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio  = false
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                HomeHeader
                
                columnTitle
                
                if !showPortfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio{
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
               
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
    
    private var allCoinList :some View{
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn:false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
         }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList :some View{
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn:true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
         }
        .listStyle(.plain)
    }
    
    private var columnTitle : some View{
        HStack{
            Text("Coin")
            Spacer()
            
            if showPortfolio{
                Text("Holding")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(.secondaryText)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(HomeViewModel())
}
