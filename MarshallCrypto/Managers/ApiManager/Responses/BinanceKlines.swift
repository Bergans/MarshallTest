//
//  BinanceKlines.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

enum JSONValue: Decodable {
    case string(String)
    case int(Int)
    case array([JSONValue])

    // Decode each type dynamically
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let array = try? container.decode([JSONValue].self) {
            self = .array(array)
        } else {
            throw DecodingError.typeMismatch(
                JSONValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unsupported type")
            )
        }
    }
}
