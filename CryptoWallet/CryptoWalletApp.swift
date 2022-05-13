//
//  CryptoWalletApp.swift
//  CryptoWallet
//
//  Created by ricardo silva on 09/05/2022.
//

import SwiftUI

@main
struct CryptoWalletApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .preferredColorScheme(.dark)
            .environmentObject(vm)
        }
    }
}
