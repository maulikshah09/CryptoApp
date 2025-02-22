//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/22/25.
//

import SwiftUI
import Combine

struct CoinImageView: View {
    
    var url : URL
    var body: some View {
        
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
            case .failure:
                errorView()
                
            case .empty:
                ProgressView()
            default:
                errorView()
            }
        }
    }
    
    func errorView() -> some View{
        Image(systemName: "exclamationmark.triangle.fill") // Exclamation icon
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.red)
    }
}

//#Preview {
//    CoinImageView(coin: dev.coin)
//}
//
//
