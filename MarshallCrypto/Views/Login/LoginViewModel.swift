//
//  LoginViewModel.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    private let managerProvider: ManagerProviderProtocol
    private var userManager: UserManagerProtocol { managerProvider.userManager }

    @Published var error: String?
    
    init(managerProvider: ManagerProviderProtocol) {
        self.managerProvider = managerProvider
    }

    func login() {
        Task {
            do {
                try await userManager.login()
            } catch {
                await MainActor.run {
                    self.error = "Can't get crypto exchange rates"
                }
            }
        }
    }
}
