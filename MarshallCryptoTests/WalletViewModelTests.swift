//
//  WalletViewModelTests.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import XCTest
@testable import MarshallCrypto

final class WalletViewModelTests: XCTestCase {
    let managerProvider = MockManagerProvider()
    let ballances: [Ballance] = [
        .init(currency: .btc, amount: 1.23, amountInUsd: 2.34),
        .init(currency: .eth, amount: 3.45, amountInUsd: 2.34)
    ]


    func testCreate() async throws {
        managerProvider.userManager.user.send(true)
        (managerProvider.userManager as? MockUserManager)?.ballances = ballances

        let model = WalletViewModel(managerProvider: managerProvider)
        XCTAssertEqual(model.ballances, ballances)
        XCTAssertEqual(model.error, nil)
        XCTAssertEqual(model.availableCurrencies, [.usd, .sek])
        XCTAssertEqual(model.total, 4.68.asCurrency(.usd))
        XCTAssertEqual(model.currency, .usd)
    }
}
