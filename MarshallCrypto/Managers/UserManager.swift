//
//  UserManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Combine

protocol UserManagerProtocol {
    var user: CurrentValueSubject<Bool, Never> { get }
    var ballances: [Ballance] { get }
    func login() async throws
    func logout()
}

final class UserManager: UserManagerProtocol {
    private let dataManager: DataManagerProtocol

    var user: CurrentValueSubject<Bool, Never> = .init(false)
    var ballances: [Ballance] = []

    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }

    func login() async throws {
        ballances = try await dataManager.getBallances()
        user.send(true)
    }

    func logout() {
        user.send(false)
        ballances = []
    }
}
