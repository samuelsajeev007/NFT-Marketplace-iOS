//
//  PlaceholderView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

/// A generic placeholder view used during the architecture phase.
///
/// Replace each usage with the real screen implementation in the UI phase.
/// The `systemImage` and `title` parameters make it easy to distinguish
/// destinations in the simulator without building actual UI.
struct PlaceholderView: View {

    // MARK: - Properties

    let title: String
    let systemImage: String

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.custom("Poppins-Regular", size: 48))
                .foregroundStyle(.secondary)

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            Text("Screen not yet implemented.")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PlaceholderView(title: "Marketplace", systemImage: "storefront")
    }
}
