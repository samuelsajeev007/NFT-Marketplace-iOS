//
//  WalletBalanceResponse.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - WalletBalanceResponse

/// A wrapper to decode the root API response which contains an array of balances.
struct WalletBalanceResponse: Codable, Sendable {
    let coins: [WalletBalance]
}
