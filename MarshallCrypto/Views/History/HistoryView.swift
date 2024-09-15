//
//  HistoryView.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI
import Charts

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel

    init(viewModel: @autoclosure @escaping () -> HistoryViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }

    var body: some View {
        Text("Historical prices last 2 weeks")
            .font(.largeTitle)
            .padding(.bottom, 16)
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5, anchor: .center)
        } else {
            ErrorView(errorText: $viewModel.error)
            Chart(viewModel.chartData) { history in
                LineMark(
                    x: .value("Date", history.date),
                    y: .value("Rate", history.rate)
                )
                .foregroundStyle(Color.blue)
                .symbol(Circle())
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 1)) {
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks()
            }
            .frame(height: 300)
        }
    }
}
