//
//  Endpoints.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Foundation

protocol Endpoint {
    func getURL() throws -> URL
}

enum ApiEndpoints: Endpoint {
    case usdExchangeRate
    case crypto
    case cryptoHistory(Currency)

    private var url: URL? {
        switch self {
        case .crypto:
            URL(string: "https://api.wazirx.com/sapi/v1/tickers/24hr")
        case .usdExchangeRate:
            URL(string: "https://open.er-api.com/v6/latest/USD")
        case .cryptoHistory(let currency):
            URL(string: "https://api.binance.com/api/v3/uiKlines?symbol=\(currency.rawValue.uppercased())USDT&interval=1d&limit=14")
        }
    }

    func getURL() throws -> URL {
        guard let url else { throw CustomError.invalidURL }
        return url
    }
}
