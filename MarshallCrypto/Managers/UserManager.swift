//
//  UserManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Combine

protocol UserManagerProtocol {
    var user: CurrentValueSubject<Bool, Never> { get }
    var ballances: [Ballance] { get }
    func login() async throws
    func logout()
}

final class UserManager: UserManagerProtocol {
    private let dataManager: DataManagerProtocol

    var user: CurrentValueSubject<Bool, Never> = .init(false)
    var ballances: [Ballance] = []

    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }

    func login() async throws {
        ballances = try await getBallances()
        user.send(true)
    }

    func logout() {
        user.send(false)
    }
}

extension UserManager {
    func getBallances() async throws ->  [Ballance] {
        let cryptoRates = try await dataManager.getCryptoRates()

        var ballances: [Ballance] = []
        var availableCurrencies = Currency.allCases.suffix(from: 2)
        let currenciesInWallet = Int.random(in: 0..<availableCurrencies.count)
        for _ in 0...currenciesInWallet {
            let index = Int.random(in: availableCurrencies.indices)
            let currency = availableCurrencies[index]
            let amount = Double.random(in: 0.1...10.0)
            let amountInUsd = amount * (cryptoRates[currency] ?? 0)

            ballances.append(.init(currency: currency, amount: amount, amountInUsd: amountInUsd))
            availableCurrencies.remove(at: index)
        }

        return ballances
    }
}
