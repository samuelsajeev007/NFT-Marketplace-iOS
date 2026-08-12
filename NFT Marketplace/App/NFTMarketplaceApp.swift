//
//  NFTMarketplaceApp.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

@main
struct NFTMarketplaceApp: App {

    // MARK: - App Container

    /// The central dependency container, created once for the lifetime of the app.
    private let container: AppContainer = AppContainer()

    // MARK: - Scene

    var body: some Scene {
        WindowGroup {
            AppRootView()
                // `@Observable` objects are injected via `.environment(_:)`,
                // not `.environmentObject(_:)`.
                .environment(container.appRouter)
                .environment(container.marketplaceViewModel)
                .environment(container.walletViewModel)
                .environment(container.walletViewModel)
                .environment(container.createNFTViewModel)
                .environment(container)
        }
    }
}
