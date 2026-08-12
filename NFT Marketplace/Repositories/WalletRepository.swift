//
//  WalletRepository.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - WalletRepositoryProtocol

/// Contract for all wallet-related data operations.
protocol WalletRepositoryProtocol {

    /// Fetches the user's cryptocurrency balances, including USDT.
    func fetchBalances() async throws -> [WalletBalance]

    /// Fetches NFTs that the authenticated user has purchased.
    func fetchOwnedNFTs() async throws -> [NFT]
}

// MARK: - WalletRepository

/// Concrete implementation of `WalletRepositoryProtocol`.
final class WalletRepository: WalletRepositoryProtocol {

    // MARK: - Properties

    private let networkService: NetworkServiceProtocol

    // MARK: - Init

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - WalletRepositoryProtocol

    func fetchBalances() async throws -> [WalletBalance] {
        try await networkService.request(
            endpoint: .walletBalances,
            responseType: [WalletBalance].self
        )
    }

    func fetchOwnedNFTs() async throws -> [NFT] {
        try await networkService.request(
            endpoint: .ownedNFTs,
            responseType: [NFT].self
        )
    }
}
