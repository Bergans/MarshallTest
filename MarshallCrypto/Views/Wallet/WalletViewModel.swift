//
//  WalletViewModel.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI
import Combine

final class WalletViewModel: ObservableObject {
    private let managerProvider: ManagerProviderProtocol
    private var userManager: UserManagerProtocol { managerProvider.userManager }
    private var dataManager: DataManagerProtocol { managerProvider.dataManager }

    @Published var currency: Currency = .usd
    @Published var total: String = 123.00.asCurrency(.usd)
    @Published var error: String?
    let availableCurrencies: [Currency] = [.usd, .sek]
    var ballances: [Ballance] = []
    private var totalInUsd: Double = 0
    private var cancellables: Set<AnyCancellable> = []

    init(managerProvider: ManagerProviderProtocol) {
        self.managerProvider = managerProvider
        ballances = userManager.ballances
        totalInUsd = ballances.reduce(0.0) {
            $0 + $1.amountInUsd
        }

        $currency.sink { [weak self] selectedCurrency in
            guard let self else { return }
            if selectedCurrency == .usd {
                total = totalInUsd.asCurrency(.usd)
            } else {
                Task { [weak self] in
                    await self?.convertToSek()
                }
            }
        }
        .store(in: &cancellables)
    }

    func logout() {
        userManager.logout()
    }

    func historyViewModel(for currency: Currency) -> HistoryViewModel {
        .init(managerProvider: managerProvider, currency: currency)
    }
}

private extension WalletViewModel {
    func convertToSek() async {
        do {
            let usdToSek = try await dataManager.getUsdToSek()
            await MainActor.run {
                total = (totalInUsd * usdToSek).asCurrency(.sek)
            }
        } catch {
            await MainActor.run {
                self.error = "Can't get USD to SEK exchange rate"
            }
        }

    }
}
