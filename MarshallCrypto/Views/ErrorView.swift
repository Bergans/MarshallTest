//
//  ErrorView.swift
//  MarshallCrypto
//
//  Created by Janis Bergs on 2024-09-15.
//

import SwiftUI

struct ErrorView: View {
    @Binding var errorText: String?

    var body: some View {
        if let error = errorText {
            HStack(alignment: .top) {
                Text(error)
                Spacer()
                Button(
                    action: { errorText = nil },
                    label: { Image(systemName: "xmark").tint(.white) })
            }
            .padding(16)
            .background(Color.red)
        }
    }
}

#Preview {
    VStack {
        ErrorView(errorText: .constant("Short error"))
        ErrorView(errorText: .constant("Long error text that\nshould take multiple lines"))
    }
}
