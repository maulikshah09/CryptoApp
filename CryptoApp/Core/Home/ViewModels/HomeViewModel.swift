//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Maulik Shah on 2/21/25.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{

    @Published var  statistics : [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 1),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value", percentageChange: -7),
    ]
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = CoinDataService()
    
    init() {
        addSubsribers()
    }
    
    
    
    func addSubsribers(){
//        dataService.$allCoins
//            .sink { [weak self] (coins) in
//                if let self = self{
//                    self.allCoins = coins
//                }
//            }
//            .store(in: &cancellables)
    
        // updates all coins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String,coins : [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        
        let lowerCasedSearchText = searchText.lowercased()
        return coins.filter { //name,symbol and id search
            $0.name.lowercased().contains(lowerCasedSearchText) ||  $0.symbol.lowercased().contains(lowerCasedSearchText) ||
                $0.id.lowercased().contains(lowerCasedSearchText)
        }
    }
}
