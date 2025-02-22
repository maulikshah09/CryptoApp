//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/21/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingColumn : Bool
    var body: some View {
        HStack{
            leftColumn
            
            Spacer()
            
            if showHoldingColumn{
                centerColumn
            }
            
            rightColumn
           
           
        }
        .font(.subheadline)
    }
}



//#Preview {
//    CoinRowView(coin: dev.coin)
//}

struct CoinRowView_Previews:PreviewProvider{
    static var previews: some View {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView{
    private var leftColumn :some View{
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(.secondaryText)
                .frame(minWidth: 30)
            
            
            
            if let url = URL(string: coin.image ?? "") {
                CoinImageView(url: url, coinId: coin.id )
            }
    
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundStyle(.accent)
            
        }
    }
    
    private var centerColumn :some View{
        VStack(alignment: .trailing) {
            Text("\(coin.currentHoldingValue.asCurrencyWith2Decimals())")
                .bold()
            
            Text(coin.currentHoldings?.asNumberString() ?? "")
        }
    }
    
    private var rightColumn :some View{
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .foregroundStyle(.accent)
            
            Text(coin.priceChangePercentage24H?.asPresentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? .txtGreen : .txtRed
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        .foregroundStyle(Color.accent)
    }
}
