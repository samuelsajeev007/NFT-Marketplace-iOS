//
//  NFTEndpoint.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

/// Defines all API endpoints used by the NFT Marketplace.
///
/// Each case represents a distinct API resource. `URLRequest` construction
/// is handled by `NetworkService`, keeping endpoint concerns separate.
enum NFTEndpoint {

    // MARK: - Marketplace

    /// Fetches a list of available NFTs.
    case listNFTs

    /// Fetches the detail of a single NFT by its identifier.
    case nftDetail(id: String)

    /// Initiates a purchase of an NFT using USDT.
    case purchaseNFT(nftID: String)

    // MARK: - Wallet

    /// Fetches cryptocurrency balances for the authenticated user.
    case walletBalances

    /// Fetches NFTs owned by the authenticated user.
    case ownedNFTs

    // MARK: - Path Resolution

    /// The relative path component for each endpoint.
    var path: String {
        switch self {
        case .listNFTs:
            return "/beetobeeGetProducts"
        case .nftDetail(let id):
            return "/nfts/\(id)"
        case .purchaseNFT(let nftID):
            return "/nfts/\(nftID)/purchase"
        case .walletBalances:
            return "/wallet/balances"
        case .ownedNFTs:
            return "/wallet/nfts"
        }
    }

    /// The HTTP method for each endpoint.
    var httpMethod: String {
        switch self {
        case .listNFTs, .nftDetail, .walletBalances, .ownedNFTs:
            return "GET"
        case .purchaseNFT:
            return "POST"
        }
    }
}
