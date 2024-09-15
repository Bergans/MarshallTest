//
//  UserManagerTests.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Testing
@testable import MarshallCrypto

struct UserManagerTests {
    let dataManager = MockDataManager()
    let ballances: [Ballance] = [
        .init(currency: .btc, amount: 1.23, amountInUsd: 2.34),
        .init(currency: .eth, amount: 3.45, amountInUsd: 2.34)
    ]

    @Test func login() async throws {
        let userManager = UserManager(dataManager: dataManager)
        #expect(userManager.user.value == false)

        try await userManager.login()
        #expect(userManager.user.value == true)
        #expect(userManager.ballances == ballances)
    }

    @Test func logout() async throws {
        let userManager = UserManager(dataManager: dataManager)
        userManager.user.send(true)
        userManager.ballances = ballances

        userManager.logout()
        #expect(userManager.user.value == false)
        #expect(userManager.ballances == [])
    }
}
