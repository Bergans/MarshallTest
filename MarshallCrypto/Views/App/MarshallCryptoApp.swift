//
//  MarshallCryptoApp.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

@main
struct MarshallCryptoApp: App {
#if DEBUG
    @StateObject var viewModel: MarshallCryptoAppModel = MarshallCryptoAppModel()
#else
    @StateObject var viewModel: MarshallCryptoAppModel = MarshallCryptoAppModel()
#endif

    var body: some Scene {
        WindowGroup {
            if viewModel.isLoggedIn {
                WalletView(viewModel: viewModel.walletViewModel)
                    .animation(.easeIn, value: 2)
            } else {
                LoginView(viewModel: viewModel.loginViewModel)
                    .animation(.easeIn, value: 2)
            }
        }
    }
}
