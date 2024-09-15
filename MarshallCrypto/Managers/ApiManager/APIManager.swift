//
//  APIManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Foundation

enum CustomError: Error {
    case invalidURL
}

protocol APIManagerProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIManager: APIManagerProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let session = URLSession(configuration: .default)
        var request = try URLRequest(url: endpoint.getURL())
        let response = try await session.data(for: request)
        return try JSONDecoder().decode(T.self, from: response.0)
    }

}
