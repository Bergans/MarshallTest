//
//  DataManagerTests.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Testing
import Foundation
@testable import MarshallCrypto

struct DataManagerTests {
    let apiManager = MockAPIManager()


    @Test func getUsdToSek() async {
        let usdToSek: Double = 10.1
        let dataManager = DataManager(apiManager: apiManager)
        await #expect(throws: CustomError.unknown) {
            try await dataManager.getUsdToSek()
        }

        apiManager.response = ErAPILatest(rates: ["SEK": usdToSek])
        await #expect(throws: Never.self) {
            try await dataManager.getUsdToSek() == usdToSek
        }

        apiManager.response = 5.0
        await #expect(throws: Never.self) {
            try await dataManager.getUsdToSek() == usdToSek
        }
    }

    @Test func getHistory() async {
        let dataManager = DataManager(apiManager: apiManager)
        await #expect(throws: CustomError.unknown) {
            try await dataManager.getHistory(for: .btc)
        }

        let response: [[Double]] = [
            [Date().timeIntervalSince1970, 1, 2, 3],
            [Date(timeIntervalSince1970: 0).timeIntervalSince1970, 1, 2, 3]
        ]

        apiManager.response = response
        await #expect(throws: Never.self) {
            try await dataManager.getHistory(for: .btc).count == 2
        }
    }
}
