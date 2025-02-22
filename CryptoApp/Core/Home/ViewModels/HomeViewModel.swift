//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/21/25.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = CoinDataService()
    
    init() {
        addSubsribers()
    }
    
    func addSubsribers(){
        dataService.$allCoins
            .sink { [weak self] (coins) in
                if let self = self{
                    self.allCoins = coins
                }
            }
            .store(in: &cancellables)
    }
}
