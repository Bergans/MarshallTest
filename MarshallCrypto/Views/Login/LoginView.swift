//
//  LoginView.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    init(viewModel: @autoclosure @escaping () -> LoginViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }
    
    var body: some View {
        Text("Login Screen")
        Button("Login") {
            viewModel.login()
        }
    }
}

#Preview {
    LoginView(viewModel: .init(managerProvider: MockManagerProvider()))
}
