//
//  UserManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import Combine

protocol UserManagerProtocol {
    var user: CurrentValueSubject<Bool, Never> { get }
    func login()
    func logout()
}

final class UserManager: UserManagerProtocol {
    var user: CurrentValueSubject<Bool, Never> = .init(false)

    func login() {
        user.send(true)
    }

    func logout() {
        user.send(false)
    }
}
