//
//  MockAPIManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

#if DEBUG
final class MockAPIManager: APIManagerProtocol {
    var response: Decodable?
    var error: Error?

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let returnResponse = response as? T else {
            throw error ?? CustomError.unknown
        }

        return returnResponse
    }
}
#endif
