//
//  WalletViewModel.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation
import Observation

// MARK: - WalletViewModel

/// ViewModel for the My Wallet feature (My NFTs + Crypto Wallet).
///
/// Responsibilities:
/// - Fetch and expose the user's owned NFTs.
/// - Fetch and expose the user's cryptocurrency balances, including USDT.
/// - Surface loading and error state to the View.
///
/// Uses the `@Observable` macro (iOS 17+) rather than `ObservableObject`.
/// `@MainActor` guarantees main-thread updates for all observable properties.
@MainActor
@Observable
final class WalletViewModel {

    // MARK: - Observable State

    /// NFTs owned (purchased) by the authenticated user.
    private(set) var ownedNFTs: [NFT] = []

    /// Cryptocurrency balances, including USDT.
    private(set) var balances: [WalletBalance] = []

    /// Indicates whether a network request is in flight.
    private(set) var isLoading: Bool = false

    /// Holds the most recent error to display to the user.
    private(set) var errorMessage: String?

    // MARK: - Computed Properties

    /// Convenience accessor for the USDT balance, if available.
    var usdtBalance: WalletBalance? {
        balances.first { $0.symbol == AppConstants.Currency.purchaseCurrencySymbol }
    }

    // MARK: - Dependencies

    private let walletRepository: WalletRepositoryProtocol

    // MARK: - Init

    init(walletRepository: WalletRepositoryProtocol) {
        self.walletRepository = walletRepository
    }

    // MARK: - Intent Handlers

    /// Loads both owned NFTs and balances concurrently.
    /// Called when the wallet screen appears or the user pulls to refresh.
    func loadWalletData() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            // Fetch both data sets concurrently for better performance.
            async let fetchedNFTs = walletRepository.fetchOwnedNFTs(userId: "user-001", email: "jane.cooper@example.com")
            async let fetchedBalances = walletRepository.fetchBalances(userId: "user-001", email: "jane.cooper@example.com")

            ownedNFTs = try await fetchedNFTs
            balances = try await fetchedBalances
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
