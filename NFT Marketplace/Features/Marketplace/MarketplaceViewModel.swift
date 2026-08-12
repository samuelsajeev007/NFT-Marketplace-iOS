//
//  MarketplaceViewModel.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation
import Observation

// MARK: - MarketplaceViewModel

/// ViewModel for the Marketplace feature.
///
/// Responsibilities:
/// - Fetch and expose the paginated list of NFTs.
/// - Coordinate the purchase flow.
/// - Surface loading and error state to the View.
///
/// Uses the `@Observable` macro (iOS 17+) rather than `ObservableObject`.
/// Views observe only the specific properties they read, improving performance.
/// `@MainActor` guarantees that all state mutations occur on the main thread.
@MainActor
@Observable
final class MarketplaceViewModel {

    // MARK: - Observable State

    /// NFTs loaded from the marketplace.
    private(set) var nfts: [NFT] = []

    /// Indicates whether a network request is in flight.
    private(set) var isLoading: Bool = false

    /// Holds the most recent error to display to the user.
    private(set) var errorMessage: String?

    /// `true` while a purchase is being processed.
    private(set) var isPurchasing: Bool = false

    // MARK: - Private State

    private var currentPage: Int = 1
    private var canLoadMore: Bool = true

    // MARK: - Dependencies

    private let marketplaceRepository: MarketplaceRepositoryProtocol

    // MARK: - Init

    init(marketplaceRepository: MarketplaceRepositoryProtocol) {
        self.marketplaceRepository = marketplaceRepository
    }

    // MARK: - Intent Handlers

    /// Called when the marketplace screen appears or the user pulls to refresh.
    func loadNFTs() async {
        guard !isLoading else { return }
        currentPage = 1
        canLoadMore = true
        nfts = []
        await fetchNextPage()
    }

    /// Called when the user scrolls near the bottom of the list.
    func loadMoreIfNeeded(currentItem: NFT) async {
        guard canLoadMore, !isLoading else { return }
        guard let lastNFT = nfts.last, lastNFT.id == currentItem.id else { return }
        await fetchNextPage()
    }

    /// Called when the user confirms a purchase.
    func purchase(nft: NFT) async {
        guard !isPurchasing else { return }
        isPurchasing = true
        errorMessage = nil

        do {
            let updatedNFT = try await marketplaceRepository.purchaseNFT(id: nft.id)
            if let index = nfts.firstIndex(where: { $0.id == updatedNFT.id }) {
                nfts[index] = updatedNFT
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isPurchasing = false
    }

    // MARK: - Private Helpers

    private func fetchNextPage() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetched = try await marketplaceRepository.fetchNFTs(
                page: currentPage,
                pageSize: AppConstants.Pagination.defaultPageSize
            )
            nfts.append(contentsOf: fetched)
            canLoadMore = fetched.count == AppConstants.Pagination.defaultPageSize
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
