//
//  DetailViewModel.swift
//  CryptoWallet
//
//  Created by ricardo silva on 13/05/2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [Statistic] = []
    @Published var aditionalStatistics: [Statistic] = []
    
    @Published var coin: Coin
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.aditionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        //OVERVIEW ARRAY
        let overviewArray = createOverviewArray(coin: coin)
        //ADDITIONAL ARRAY
        let additionalArray = createAdditionalArray(coinDetail: coinDetail, coin: coin)
        
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        //Price Statistics
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        //MarketCap Statistics
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        //Rank Statistics
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        //Volume Statistics
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        let overviewArray: [Statistic] =  [
            priceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
        
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentageChange)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [Statistic] = [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat,
            blockStat,
            hashingStat
        ]
        
        return additionalArray
    }
}
