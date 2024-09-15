//
//  WalletViewModel.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

final class WalletViewModel: ObservableObject {
    private let managerProvider: ManagerProviderProtocol
    private var userManager: UserManagerProtocol { managerProvider.userManager }

    init(managerProvider: ManagerProviderProtocol) {
        self.managerProvider = managerProvider
    }

    func logout() {
        userManager.logout()
    }
}
