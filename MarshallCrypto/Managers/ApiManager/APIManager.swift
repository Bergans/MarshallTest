//
//  APIManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case unknown
}

protocol APIManagerProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIManager: APIManagerProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await getResponse(endpoint)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func getResponse(_ endpoint: Endpoint) async throws -> Data {
        do {
            let session = URLSession(configuration: .default)
            let request = try URLRequest(url: endpoint.getURL())
            let response = try await session.data(for: request)

            return response.0
        } catch {
            throw error
        }
    }
}
