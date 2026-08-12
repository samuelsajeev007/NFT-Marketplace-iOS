//
//  User.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - User

/// Represents the authenticated user of the application.
///
/// Extend this model as the authentication and profile features are defined.
struct User: Identifiable, Codable, Hashable {

    // MARK: Properties

    /// Unique identifier for the user account.
    let id: String

    /// Display name shown in the UI.
    let displayName: String

    /// User's email address (may be used for account management).
    let email: String

    /// Optional URL to the user's profile avatar.
    let avatarURL: URL?

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case email
        case avatarURL = "avatar_url"
    }
}
