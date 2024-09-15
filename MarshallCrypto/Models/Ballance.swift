//
//  Ballance.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

struct Ballance: Equatable {
    let currency: Currency
    let amount: Double
    let amountInUsd: Double

    var displayAmount: String {
        amount.asCurrency(currency)
    }
}
