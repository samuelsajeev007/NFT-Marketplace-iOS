//
//  MarketplaceRepository.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - MarketplaceRepositoryProtocol

/// Contract for all marketplace data operations.
///
/// ViewModels depend on this protocol rather than the concrete type, so the
/// actual network call can be swapped for an in-memory stub in tests.
protocol MarketplaceRepositoryProtocol {

    /// Fetches a paginated list of NFTs available in the marketplace.
    func fetchNFTs(page: Int, pageSize: Int) async throws -> [NFT]

    /// Fetches the full detail of a single NFT.
    func fetchNFTDetail(id: String) async throws -> NFT

    /// Initiates the purchase of an NFT using USDT.
    func purchaseNFT(id: String, userId: String, email: String) async throws
}

// MARK: - MarketplaceRepository

/// Concrete implementation of `MarketplaceRepositoryProtocol`.
///
/// Translates domain-level calls into `NetworkService` requests.
/// Add caching or local persistence layers here if needed.
final class MarketplaceRepository: MarketplaceRepositoryProtocol {

    // MARK: - Properties

    private let networkService: NetworkServiceProtocol

    // MARK: - Init

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - MarketplaceRepositoryProtocol

    func fetchNFTs(page: Int, pageSize: Int) async throws -> [NFT] {
        let response = try await networkService.request(
            endpoint: .listNFTs,
            responseType: NFTResponse.self
        )
        return response.items
    }

    func fetchNFTDetail(id: String) async throws -> NFT {
        try await networkService.request(
            endpoint: .nftDetail(id: id),
            responseType: NFT.self
        )
    }

    func purchaseNFT(id: String, userId: String, email: String) async throws {
        _ = try await networkService.request(
            endpoint: .purchaseNFT(nftID: id, userId: userId, email: email),
            responseType: EmptyResponse.self
        )
    }
}
