//
//  MarshallCryptoApp.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

@main
struct MarshallCryptoApp: App {
    enum NavigationDestination: Hashable {
        case wallet
    }

    @StateObject var viewModel: MarshallCryptoAppModel = MarshallCryptoAppModel()
    @State var navigationPath = NavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                LoginView(viewModel: viewModel.loginViewModel)
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .wallet:
                            WalletView(viewModel: viewModel.walletViewModel)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .onReceive(viewModel.$isLoggedIn) {
                navigationPath = NavigationPath()
                if $0 {
                    navigationPath.append(NavigationDestination.wallet)
                }
            }

        }
    }
}
