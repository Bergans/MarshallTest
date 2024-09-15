//
//  WalletViewModelTests.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Testing

@testable import MarshallCrypto

struct WalletViewModelTests {
    let managerProvider = MockManagerProvider()
    let ballances: [Ballance] = [
        .init(currency: .btc, amount: 1.23, amountInUsd: 2.34),
        .init(currency: .eth, amount: 3.45, amountInUsd: 2.34)
    ]


    @Test func create() async throws {
        managerProvider.userManager.user.send(true)
        (managerProvider.userManager as? MockUserManager)?.ballances = ballances

        let model = WalletViewModel(managerProvider: managerProvider)
        #expect(model.ballances == ballances)
        #expect(model.error == nil)
        #expect(model.availableCurrencies == [.usd, .sek])
        #expect(model.total == 4.68.asCurrency(.usd))
        #expect(model.currency == .usd)
    }
}
