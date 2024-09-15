//
//  MarshallCryptoAppModel.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Combine
import SwiftUI

final class MarshallCryptoAppModel: ObservableObject {
    private let managerProvider: ManagerProviderProtocol = ManagerProvider()

    @Published var isLoggedIn: Bool = false
    var loginViewModel: LoginViewModel { .init(managerProvider: managerProvider) }
    var walletViewModel: WalletViewModel { .init(managerProvider: managerProvider) }

    init() {
        managerProvider.userManager.user.assign(to: &$isLoggedIn)
    }
}
