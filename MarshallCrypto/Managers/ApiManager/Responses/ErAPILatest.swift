//
//  ErAPILatest.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

// Full response available at https://www.exchangerate-api.com/docs/standard-requests

struct ErAPILatest: Decodable {
    let rates: [String: Double]
}
