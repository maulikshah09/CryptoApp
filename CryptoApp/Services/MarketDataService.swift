//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Maulik Shah on 3/12/25.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel?
    var marketSubscribe : AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else{
            return
        }
        
    marketSubscribe =  NetworkingManager.download(url: url)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnGlobalData in
                self?.marketData = returnGlobalData.data
                self?.marketSubscribe?.cancel()
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
