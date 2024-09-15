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
        if let error = viewModel.error {
            HStack(alignment: .top) {
                Text(error)
                Spacer()
                Button(
                    action: { viewModel.error = nil },
                    label: { Image(systemName: "xmark") })
            }
        }
        
        Text("Login Screen")
        Button("Login") {
            viewModel.login()
        }
    }
}

#Preview {
    LoginView(viewModel: .init(managerProvider: MockManagerProvider()))
}
