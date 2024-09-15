//
//  WalletView.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

struct WalletView: View {
    @StateObject var viewModel: WalletViewModel

    init(viewModel: @autoclosure @escaping () -> WalletViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }

    var body: some View {
        Text("Wallet view")
        Button("Login") {
            viewModel.logout()
        }
    }
}

#Preview {
    WalletView(viewModel: .init(managerProvider: MockManagerProvider()))
}
