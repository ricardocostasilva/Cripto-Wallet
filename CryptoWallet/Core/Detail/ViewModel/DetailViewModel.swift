//
//  DetailViewModel.swift
//  CryptoWallet
//
//  Created by ricardo silva on 13/05/2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailDataService.$coinDetails
            .sink { returnedCoinDetails in
                print("Received Coin Detail Data:")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
    
}
