//
//  AppRootView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

/// Root view of the application.
///
/// Owns the `NavigationStack` bound to `AppRouter.path` and resolves each
/// `AppRoute` to its corresponding destination view. This is the single place
/// where route-to-view mapping lives; no other view should push views directly.
///
/// Screens are stubbed with `PlaceholderView` until the UI phase is implemented.
struct AppRootView: View {

    // MARK: - Environment

    /// With the `@Observable` macro, routers are accessed via `@Environment`
    /// rather than `@EnvironmentObject`.
    @Environment(AppRouter.self) private var router

    // MARK: - Body

    var body: some View {
        /// `@Bindable` is required to create a binding to a property on an
        /// `@Observable` object that is not itself a `@State` variable.
        @Bindable var router = router

        NavigationStack(path: $router.path) {
            // The root content — the home screen containing marketplace and wallet tabs.
            HomeScreen()
                .navigationDestination(for: AppRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }

    // MARK: - Route Resolution

    @ViewBuilder
    private func destinationView(for route: AppRoute) -> some View {
        switch route {
        case .marketplace:
            PlaceholderView(title: "Marketplace", systemImage: "storefront")

        case .nftDetail(let nftID):
            PlaceholderView(title: "NFT Detail – \(nftID)", systemImage: "photo.artframe")

        case .purchaseFlow(let nftID):
            PlaceholderView(title: "Purchase – \(nftID)", systemImage: "creditcard")

        case .wallet:
            PlaceholderView(title: "My Wallet", systemImage: "wallet.pass")

        case .myNFTs:
            PlaceholderView(title: "My NFTs", systemImage: "photo.stack")

        case .cryptoWallet:
            PlaceholderView(title: "Crypto Wallet", systemImage: "bitcoinsign.circle")
        }
    }
}

// MARK: - Preview

#Preview {
    AppRootView()
        .environment(AppRouter())
}
