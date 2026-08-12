//
//  EmptyResponse.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

/// A placeholder response for endpoints that do not return a JSON body,
/// or where the body is intentionally ignored.
struct EmptyResponse: Codable {
    // No properties to decode.
}
