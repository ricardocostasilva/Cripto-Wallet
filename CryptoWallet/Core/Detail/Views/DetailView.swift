//
//  DetailView.swift
//  CryptoWallet
//
//  Created by ricardo silva on 13/05/2022.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                
                overviewTitle
                Divider()
                overviewGrid
                additionalTitle
                Divider()
                additionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}


extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.aditionalStatistics) { stat in
                    StatisticView(stat: stat)
            }
        }
    }
}
