//
//  CryptoWalletApp.swift
//  CryptoWallet
//
//  Created by ricardo silva on 09/05/2022.
//

import SwiftUI

@main
struct CryptoWalletApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
