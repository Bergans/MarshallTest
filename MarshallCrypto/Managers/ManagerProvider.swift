//
//  ManagerProvider.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

protocol ManagerProviderProtocol {
    var userManager: UserManagerProtocol { get }
    var dataManager: DataManagerProtocol { get }
}

final class ManagerProvider: ManagerProviderProtocol {
    let userManager: UserManagerProtocol
    private let apiManager: APIManagerProtocol
    let dataManager: DataManagerProtocol

    init() {
        apiManager = APIManager()
        dataManager = DataManager(apiManager: apiManager)
        userManager = UserManager(dataManager: dataManager)
    }
}
