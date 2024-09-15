//
//  ManagerProvider.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

protocol ManagerProviderProtocol {
    var userManager: UserManagerProtocol { get }
}

final class ManagerProvider: ManagerProviderProtocol {
    let userManager: UserManagerProtocol = UserManager()
}
