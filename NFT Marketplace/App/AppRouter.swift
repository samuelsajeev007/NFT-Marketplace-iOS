//
//  AppRouter.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI
import Observation

// MARK: - AppRoute

/// Represents every navigable destination in the application.
///
/// Add new cases here as features are implemented. Each case carries only the
/// data that the destination view needs — no view references are stored here.
enum AppRoute: Hashable {

    // MARK: Marketplace

    /// The main marketplace listing screen.
    case marketplace

    /// Detail view for a single NFT.
    case nftDetail(nft: NFT)

    /// Purchase confirmation / flow for a given NFT.
    case purchaseFlow(nft: NFT)

    // MARK: Wallet

    /// The wallet hub (My NFTs + Crypto Wallet).
    case wallet

    /// Grid / list of NFTs owned by the current user.
    case myNFTs

    /// Cryptocurrency balance screen.
    case cryptoWallet
}

// MARK: - AppRouter

/// Observable router that drives `NavigationStack` via a path binding.
///
/// Uses the `@Observable` macro (iOS 17+) rather than `ObservableObject`,
/// which is the modern approach for this project's deployment target.
/// Inject via the SwiftUI environment using `.environment(router)` at the root.
@MainActor
@Observable
final class AppRouter {

    // MARK: - State

    /// The current navigation path. Bind this to `NavigationStack(path:)`.
    var path: [AppRoute] = []

    // MARK: - Navigation Actions

    /// Pushes a new destination onto the navigation stack.
    func navigate(to route: AppRoute) {
        path.append(route)
    }

    /// Pops the top-most destination.
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    /// Pops to the root of the current navigation stack.
    func navigateToRoot() {
        path.removeAll()
    }

    /// Replaces the entire navigation path (e.g. deep-link handling).
    func replace(with routes: [AppRoute]) {
        path = routes
    }
}
