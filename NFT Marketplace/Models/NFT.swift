//
//  NFT.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - NFT

/// Represents a single Non-Fungible Token available in the marketplace.
///
/// Explicitly conforms to `Sendable` so instances can be safely passed across
/// actor boundaries (e.g. from the network layer back to the `@MainActor`
/// ViewModel).
///
/// `init(from:)` is marked `nonisolated` to prevent the compiler from
/// inferring `@MainActor` isolation (due to the project-wide
/// `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` build setting), which would
/// otherwise break the `Sendable` requirement on the generic network layer.
struct NFT: Identifiable, Hashable, Sendable {

    // MARK: Properties

    /// Unique identifier for the NFT (as provided by the backend).
    let id: String

    /// Display name of the NFT.
    let title: String

    /// Short description of the NFT.
    let description: String?

    /// Remote URL pointing to the NFT's image or media asset.
    let imageUrl: URL?

    /// Creator / artist of the NFT.
    let createdBy: String

    /// Price in USDT.
    let price: Decimal

    /// Currency symbol (e.g. USDT)
    let currency: String?

    /// Current availability status.
    let available: Bool

    /// Timestamp when the NFT was listed.
    let createdAt: Date?
}

// MARK: - Codable

extension NFT: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case imageUrl
        case createdBy
        case price
        case currency
        case available
        case createdAt
    }

    /// `nonisolated` prevents the compiler from applying `@MainActor` isolation
    /// to this initialiser, keeping decoding available on any thread/executor.
    nonisolated init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id          = try container.decode(String.self,    forKey: .id)
        title       = try container.decode(String.self,    forKey: .title)
        description = try container.decodeIfPresent(String.self,    forKey: .description)
        imageUrl    = try container.decodeIfPresent(URL.self,    forKey: .imageUrl)
        createdBy   = try container.decode(String.self,    forKey: .createdBy)
        price       = try container.decode(Decimal.self,   forKey: .price)
        currency    = try container.decodeIfPresent(String.self, forKey: .currency)
        available   = try container.decode(Bool.self, forKey: .available)
        
        let dateString = try container.decodeIfPresent(String.self, forKey: .createdAt)
        if let dateString = dateString {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            createdAt = formatter.date(from: dateString)
        } else {
            createdAt = nil
        }
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,          forKey: .id)
        try container.encode(title,       forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(imageUrl,  forKey: .imageUrl)
        try container.encode(createdBy,   forKey: .createdBy)
        try container.encode(price,       forKey: .price)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encode(available,   forKey: .available)
        
        if let createdAt = createdAt {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            try container.encode(formatter.string(from: createdAt), forKey: .createdAt)
        }
    }
}
