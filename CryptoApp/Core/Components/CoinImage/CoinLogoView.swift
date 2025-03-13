//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 3/14/25.
//

import SwiftUI

struct CoinLogoView: View {
    let coin : CoinModel
    var body: some View {
        VStack{
            if let image = coin.image,let url = URL(string: image){
                CoinImageView(url: url, coinId: coin.id)
                    .frame(width: 50,height: 50)
            }
           
                
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

//#Preview {
//    CoinLogoView(coin: CoinModel())
//}
