//
//  UserManagerTests.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import XCTest
@testable import MarshallCrypto

final class UserManagerTests: XCTestCase {
    let dataManager = MockDataManager()
    let ballances: [Ballance] = [
        .init(currency: .btc, amount: 1.23, amountInUsd: 2.34),
        .init(currency: .eth, amount: 3.45, amountInUsd: 2.34)
    ]

    func testLogin() async throws {
        dataManager.ballances = ballances
        let userManager = UserManager(dataManager: dataManager)
        XCTAssertEqual(userManager.user.value, false)

        try await userManager.login()
        XCTAssertEqual(userManager.user.value, true)
        XCTAssertEqual(userManager.ballances, ballances)
    }

    func testLogout() async throws {
        let userManager = UserManager(dataManager: dataManager)
        userManager.user.send(true)
        userManager.ballances = ballances

        userManager.logout()
        XCTAssertEqual(userManager.user.value, false)
        XCTAssertEqual(userManager.ballances, [])
    }
}
