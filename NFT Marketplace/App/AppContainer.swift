//
//  AppContainer.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

/// `AppContainer` is the top-level dependency injection container.
///
/// It owns and vends all shared services, repositories, and the router.
/// ViewModels should receive their dependencies via initialiser injection,
/// sourcing them from this container through the root view or the environment.
///
/// To support unit testing, replace concrete types with protocol-backed mocks
/// before constructing the container.
final class AppContainer {

    // MARK: - Router

    let appRouter: AppRouter

    // MARK: - Services

    let networkService: NetworkServiceProtocol

    // MARK: - Repositories

    let marketplaceRepository: MarketplaceRepositoryProtocol
    let walletRepository: WalletRepositoryProtocol

    // MARK: - ViewModels

    let marketplaceViewModel: MarketplaceViewModel
    let walletViewModel: WalletViewModel

    // MARK: - Init

    init() {
        // Services
        let networkService = NetworkService()
        self.networkService = networkService

        // Repositories
        self.marketplaceRepository = MarketplaceRepository(networkService: networkService)
        self.walletRepository = WalletRepository(networkService: networkService)

        // Router
        self.appRouter = AppRouter()

        // ViewModels
        self.marketplaceViewModel = MarketplaceViewModel(marketplaceRepository: self.marketplaceRepository)
        self.walletViewModel = WalletViewModel(walletRepository: self.walletRepository)
    }
}
