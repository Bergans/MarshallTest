//
//  MockManagerProvider.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

#if DEBUG
final class MockManagerProvider: ManagerProviderProtocol {
    let userManager: UserManagerProtocol = MockUserManager()
    let dataManager: DataManagerProtocol = MockDataManager()
}
#endif
