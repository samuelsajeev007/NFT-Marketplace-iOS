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
/// The marketplace uses USDT as the primary purchase currency, but the wallet
/// screen may display additional token balances as the feature grows.
///
/// Explicitly conforms to `Sendable` and provides a `nonisolated init(from:)`
/// to prevent `@MainActor` isolation from being inferred on the `Decodable`
/// initialiser (see `NFT.swift` for a full explanation).
struct WalletBalance: Identifiable, Hashable, Sendable {

    // MARK: Properties

    /// Unique identifier constructed from the currency symbol.
    var id: String { currencySymbol }

    /// Ticker symbol of the currency (e.g. "USDT", "ETH").
    let currencySymbol: String

    /// Human-readable name of the currency (e.g. "Tether", "Ethereum").
    let currencyName: String

    /// Current balance amount.
    let amount: Decimal

    /// URL for the currency's logo image.
    let logoURL: URL?
}

// MARK: - Codable

extension WalletBalance: Codable {

    enum CodingKeys: String, CodingKey {
        case currencySymbol = "currency_symbol"
        case currencyName   = "currency_name"
        case amount
        case logoURL        = "logo_url"
    }

    nonisolated init(from decoder: any Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        currencySymbol = try container.decode(String.self,  forKey: .currencySymbol)
        currencyName   = try container.decode(String.self,  forKey: .currencyName)
        amount         = try container.decode(Decimal.self, forKey: .amount)
        logoURL        = try container.decodeIfPresent(URL.self, forKey: .logoURL)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currencySymbol, forKey: .currencySymbol)
        try container.encode(currencyName,   forKey: .currencyName)
        try container.encode(amount,         forKey: .amount)
        try container.encodeIfPresent(logoURL, forKey: .logoURL)
    }
}
