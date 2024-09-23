//
//  DataManagerTests.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import XCTest
import Foundation
@testable import MarshallCrypto

final class DataManagerTests: XCTestCase {
    let apiManager = MockAPIManager()

    func testGetUsdToSek() async {
        let usdToSek: Double = 10.1
        let dataManager = DataManager(apiManager: apiManager)

        do {
            _ = try await dataManager.getUsdToSek()
        } catch {
            XCTAssertEqual(error as? CustomError, CustomError.unknown)
        }

        apiManager.response = ErAPILatest(rates: ["SEK": usdToSek])
        var usd = try? await dataManager.getUsdToSek()
        XCTAssertEqual(usd, usdToSek)

        apiManager.response = 5.0
        usd = try? await dataManager.getUsdToSek()
        XCTAssertEqual(usd, usdToSek)
    }

    func testGetHistory() async {
        let dataManager = DataManager(apiManager: apiManager)
        do {
            _ = try await dataManager.getHistory(for: .btc)
        } catch {
            XCTAssertEqual(error as? CustomError, CustomError.unknown)
        }

        let response: [[JSONValue]] = [
            [.int(Int(Date().timeIntervalSince1970)), .string("1"), .string("2"), .string("3")],
            [.int(Int(Date(timeIntervalSince1970: 0).timeIntervalSince1970)), .string("1"), .string("2"), .string("3")]
        ]

        apiManager.response = response
        let history = try? await dataManager.getHistory(for: .btc)
        XCTAssertEqual(history?.count, 2)
    }
}
