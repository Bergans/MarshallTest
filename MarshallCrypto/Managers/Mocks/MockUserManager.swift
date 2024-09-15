//
//  MockUserManager.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

#if DEBUG
import Combine

final class MockUserManager: UserManagerProtocol {
    var ballances: [Ballance] = []
    var user: CurrentValueSubject<Bool, Never> = .init(false)

    func setUser(_ newUser: Bool) {
        user.send(newUser)
    }

    func login() {}
    func logout() {}
}
#endif
