//
//  NFTResponse.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - NFTResponse

/// A wrapper to decode the root API response which contains an array of NFTs.
struct NFTResponse: Codable, Sendable {
    let items: [NFT]
}
