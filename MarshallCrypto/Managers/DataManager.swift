//
//  DataManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Foundation

protocol DataManagerProtocol {
    func getUsdToSek() async throws -> Double
    func getHistory(for currency: Currency) async throws -> [(Date, Double)]
    func getBallances() async throws ->  [Ballance]
}

final class DataManager: DataManagerProtocol {
    private let apiManager: APIManagerProtocol

    private var usdToSek: Double = 0.0
    private var cryptoRates: [Currency: Double] = [:]

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }

    func getUsdToSek() async throws -> Double {
        guard usdToSek.isZero else {
            return usdToSek
        }

        let response = try await getCurrencyExchange()
        if let conversionRate = response.rates["SEK"] {
            usdToSek = conversionRate
            return usdToSek
        } else {
            throw CustomError.unknown
        }
    }

    private func getCryptoRates() async throws -> [Currency: Double] {
        guard cryptoRates.isEmpty else {
            return cryptoRates
        }

        let response = try await getCryptoRatesFromApi()
        response
            .filter { $0.quoteAsset == "usdt" }
            .forEach {
                if let currency = Currency(rawValue: $0.baseAsset) {
                    cryptoRates[currency] = $0.lastPrice
                }
            }

        return cryptoRates
    }

    func getHistory(for currency: Currency) async throws -> [(Date, Double)] {
        var history: [(Date, Double)] = []

        let response = try await getCurrencyHistory(for: currency)
        response.forEach {
            if case let JSONValue.int(date) = $0[0],
               case let JSONValue.string(price) = $0[1] {
                let chartDate = Date(timeIntervalSince1970: Double(date/1000))
                let value = Double(price) ?? 0
                history.append((chartDate, value))
            }
        }

        return history
    }
}

extension DataManager {
    func getBallances() async throws ->  [Ballance] {
        let cryptoRates = try await getCryptoRates()

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

//MARK: - API Calls
private extension DataManager {
    func getCryptoRatesFromApi() async throws -> [WazirxTicker] {
        try await apiManager.request(ApiEndpoints.crypto)
    }

    func getCurrencyExchange() async throws -> ErAPILatest {
        try await apiManager.request(ApiEndpoints.usdExchangeRate)
    }

    func getCurrencyHistory(for currency: Currency) async throws -> [[JSONValue]] {
        try await apiManager.request(ApiEndpoints.cryptoHistory(currency))
    }
}
