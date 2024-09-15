//
//  MockDataManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

#if DEBUG
import Foundation

final class MockDataManager: DataManagerProtocol {
    func getCryptoRates() async throws -> [Currency : Double] {
        [.btc: 7325.0]
    }
    
    func getUsdToSek() async throws -> Double {
        10.232194
    }

    func getHistory(for currency: Currency) async throws -> [(Date, Double)] {
        []
    }
}
#endif
