//
//  DataManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Foundation

protocol DataManagerProtocol {
    func getCryptoRates() async throws -> [Currency: Double]
    func getUsdToSek() async throws -> Double
    func getHistory(for currency: Currency) async throws -> [(Date, Double)]
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

    func getCryptoRates() async throws -> [Currency: Double] {
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
            let date = Date(timeIntervalSince1970: $0[0])
            let value = $0[2]
            history.append((date, value))
        }

        return history
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

    func getCurrencyHistory(for currency: Currency) async throws -> [[Double]] {
        try await apiManager.request(ApiEndpoints.cryptoHistory(currency))
    }
}
