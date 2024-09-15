//
//  WazirxTickers.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

// Full response available at https://docs.wazirx.com/#market-data-endpoints

struct WazirxTicker: Decodable {
    let symbol: String
    let baseAsset: String
    let quoteAsset: String
//    let openPrice: Double
//    let lowPrice: Double
//    let highPrice: Double
    let lastPrice: Double
//    let volume: Double
//    let bidPrice: Double
//    let askPrice: Double

    enum CodingKeys: String, CodingKey {
        case symbol
        case baseAsset
        case quoteAsset
        case lastPrice
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.baseAsset = try container.decode(String.self, forKey: .baseAsset)
        self.quoteAsset = try container.decode(String.self, forKey: .quoteAsset)

        if let lastPrice = try Double(container.decode(String.self, forKey: .lastPrice)) {
            self.lastPrice = lastPrice
        } else {
            throw CustomError.unknown
        }
    }
}
