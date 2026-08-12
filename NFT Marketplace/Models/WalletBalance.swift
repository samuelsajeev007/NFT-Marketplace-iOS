//
//  WalletBalance.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - WalletBalance

/// Represents the balance of a single cryptocurrency in the user's wallet.
///
/// Explicitly conforms to `Sendable` and provides a `nonisolated init(from:)`
/// to prevent `@MainActor` isolation from being inferred on the `Decodable`
/// initialiser (see `NFT.swift` for a full explanation).
struct WalletBalance: Identifiable, Hashable, Sendable {

    // MARK: Properties

    /// Unique identifier constructed from the currency symbol.
    var id: String { symbol }

    /// The symbol of the cryptocurrency (e.g. USDT, BNB, ETH)
    let symbol: String

    /// The amount of the cryptocurrency held.
    let balance: Decimal
}

// MARK: - Codable

extension WalletBalance: Codable {

    enum CodingKeys: String, CodingKey {
        case symbol
        case balance
    }

    nonisolated init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        balance = try container.decode(Decimal.self, forKey: .balance)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(balance, forKey: .balance)
    }
}
