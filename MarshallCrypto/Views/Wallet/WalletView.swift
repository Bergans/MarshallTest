//
//  WalletView.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

struct WalletView: View {
    @StateObject var viewModel: WalletViewModel
    @State var currencyHistory: Currency?

    init(viewModel: @autoclosure @escaping () -> WalletViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ErrorView(errorText: $viewModel.error)
                Picker("", selection: $viewModel.currency) {
                    ForEach(viewModel.availableCurrencies) {
                        Text($0.name)
                            .tag($0)
                    }
                }
                .pickerStyle(.segmented)

                Text("Total: \(viewModel.total)")
                    .font(.largeTitle)
                    .padding(.bottom, 16)
                Text("Tap on currency to see price history")
                    .font(.footnote)
                    .foregroundStyle(.placeholder)
                    .padding(.bottom, 8)
                currenciesGrid(viewModel.ballances)
            }
        }
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Logout") {
                    viewModel.logout()
                }
            }
        }
        .sheet(item: $currencyHistory) {
            HistoryView(viewModel: viewModel.historyViewModel(for: $0))
        }
    }

    func currenciesGrid(_ ballances: [Ballance]) -> some View {
        Grid(alignment: .leading) {
            GridRow {
                Text("Crypto Currency")
                    .bold()
                    .padding(.trailing, 16)
                Text("Amount")
                    .bold()
                    .padding(.trailing, 16)
                Text("$")
                    .bold()
                    .padding(.trailing, 16)
            }

            ForEach(ballances, id: \.self.currency) { ballance in
                GridRow {
                    Text(ballance.currency.name)
                    Text(ballance.displayAmount)
                    Text(ballance.amountInUsd.asCurrency(.usd))
                }
                .onTapGesture {
                    currencyHistory = ballance.currency
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    let managerProvider = MockManagerProvider()
    (managerProvider.userManager as? MockUserManager)?.ballances = [
        .init(currency: .btc, amount: 1.23, amountInUsd: 2.34),
        .init(currency: .eth, amount: 2.4, amountInUsd: 4.56)
    ]

    return WalletView(viewModel: .init(managerProvider: managerProvider))
}
#endif
