//
//  HistoryViewModel.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    struct HistoryRow: Identifiable {
        let id = UUID()
        let date: Date
        let rate: Double
    }

    private let managerProvider: ManagerProviderProtocol
    private var dataManager: DataManagerProtocol { managerProvider.dataManager }
    private let currency: Currency

    @Published var isLoading = true
    @Published var chartData: [HistoryRow] = []
    @Published var error: String?

    init(managerProvider: ManagerProviderProtocol, currency: Currency) {
        self.managerProvider = managerProvider
        self.currency = currency
        
        getData()
    }
}

private extension HistoryViewModel {
    func getData() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let response = try await dataManager.getHistory(for: currency)
                await MainActor.run { [weak self] in
                    self?.chartData = response.map { .init(date: $0.0, rate: $0.1) }
                    self?.isLoading = false
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.error = "Can't Load Historical data"
                    self?.isLoading = false
                }
            }
        }
    }
}
