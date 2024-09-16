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
        VStack {
            ErrorView(errorText: $viewModel.error)

            Text("Marshall Crypto")
                .font(.largeTitle)

            Button("Login") {
                viewModel.login()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 16)
    }
}

#if DEBUG
#Preview {
    LoginView(viewModel: .init(managerProvider: MockManagerProvider()))
}
#endif
