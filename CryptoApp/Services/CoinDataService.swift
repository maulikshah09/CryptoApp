//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/21/25.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscribe : AnyCancellable?
    
    init() {
        getAllCoins()
    }
    
    func getAllCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else{
            return
        }
        
        coinSubscribe =  NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnCoin in
                self?.allCoins = returnCoin
                self?.coinSubscribe?.cancel()
            })
    }
    
    func handleDecodingError(_ error: DecodingError) {
        switch error {
        case .typeMismatch(let type, let context):
            print("Type mismatch for type \(type):", context.debugDescription)
            print("Coding Path:", context.codingPath)

        case .valueNotFound(let type, let context):
            print("Value not found for type \(type):", context.debugDescription)
            print("Coding Path:", context.codingPath)

        case .keyNotFound(let key, let context):
            print("Key '\(key.stringValue)' not found:", context.debugDescription)
            print("Coding Path:", context.codingPath)

        case .dataCorrupted(let context):
            print("Data corrupted:", context.debugDescription)
            print("Coding Path:", context.codingPath)

        @unknown default:
            print("Unknown decoding error:", error)
        }
    }
}


