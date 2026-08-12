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
    func fetchBalances(userId: String, email: String) async throws -> [WalletBalance]

    /// Uploads a new NFT for the user.
    func uploadNFT(
        imageData: Data,
        imageName: String,
        title: String,
        description: String,
        price: String,
        userId: String,
        email: String
    ) async throws

    /// Fetches the NFTs owned by the user.
    func fetchOwnedNFTs(userId: String, email: String) async throws -> [NFT]

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

    func fetchBalances(userId: String, email: String) async throws -> [WalletBalance] {
        let response = try await networkService.request(
            endpoint: .walletBalances(userid: userId, email: email),
            responseType: WalletBalanceResponse.self
        )
        return response.coins
    }

    func uploadNFT(
        imageData: Data,
        imageName: String,
        title: String,
        description: String,
        price: String,
        userId: String,
        email: String
    ) async throws {
        _ = try await networkService.request(
            endpoint: .uploadNFT(
                imageData: imageData,
                imageName: imageName,
                title: title,
                description: description,
                price: price,
                userid: userId,
                email: email
            ),
            responseType: EmptyResponse.self
        )
    }

    func fetchOwnedNFTs(userId: String, email: String) async throws -> [NFT] {
        let response = try await networkService.request(
            endpoint: .ownedNFTs(userid: userId, email: email),
            responseType: NFTResponse.self
        )
        return response.items
    }

}
