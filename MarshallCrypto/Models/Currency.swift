//
//  Currency.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

// App supports 12 most popular cryptocurrencies based on https://www.bankrate.com/investing/types-of-cryptocurrency/

enum Currency: String, Identifiable, CaseIterable {
    var id: String { rawValue }

    case usd
    case sek
    case btc
    case eth
    case bnb
    case sol
    case xrp
    case doge
    case trx
    case ton
    case ada
    case avax

    var name: String {
        switch self {
        case .usd: "US Dollar"
        case .sek: "Swedish Crown"
        case .btc: "Bitcoin"
        case .eth: "Ethereum"
        case .bnb: "BNB"
        case .sol: "Solana"
        case .xrp: "XRP"
        case .doge: "Dogecoin"
        case .trx: "TRON"
        case .ton: "Toncoin"
        case .ada: "Cardano"
        case .avax: "Avalanche"
        }
    }

    var short: String {
        switch self {
        case .usd: "$"
        default: rawValue.uppercased()
        }
    }
}

extension Double {
    func asCurrency(_ currency: Currency) -> String {
        String(format: "%.2f %@", self, currency.short)
    }
}
