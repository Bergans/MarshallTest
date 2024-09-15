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
    case currency
    case crypto

    private var url: URL? {
        switch self {
        case .crypto:
            URL(string: "https://api.wazirx.com/sapi/v1/tickers/24hr")
        case .currency:
            URL(string: "https://open.er-api.com/v6/latest/USD")
        }
    }

    func getURL() throws -> URL {
        guard let url else { throw CustomError.invalidURL }
        return url
    }
}
