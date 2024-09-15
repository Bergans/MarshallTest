//
//  MockDataManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

#if DEBUG
import Foundation

final class MockDataManager: DataManagerProtocol {
    var ballances: [Ballance] = []
    var usdToSek = 10.0

    func getUsdToSek() async throws -> Double {
        usdToSek
    }

    func getHistory(for currency: Currency) async throws -> [(Date, Double)] {
        []
    }

    func getBallances() async throws ->  [Ballance] { ballances }
}
#endif
