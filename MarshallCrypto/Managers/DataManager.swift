//
//  DataManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

protocol DataManagerProtocol {
    func getCrypto() async throws -> WazirxTickers
    func getCurrency() async throws -> ErAPILatest
}

final class DataManager: DataManagerProtocol {
    private let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }

    func getCrypto() async throws -> WazirxTickers {
        try await apiManager.request(ApiEndpoints.crypto)
    }

    func getCurrency() async throws -> ErAPILatest {
        try await apiManager.request(ApiEndpoints.currency)
    }
}
