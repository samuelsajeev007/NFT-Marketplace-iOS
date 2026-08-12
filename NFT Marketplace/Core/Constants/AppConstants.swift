//
//  AppConstants.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

/// Top-level namespace for application-wide constants.
///
/// Extend this enum with nested enums as the feature set grows. Using a
/// caseless enum prevents accidental instantiation.
enum AppConstants {

    // MARK: - API

    enum API {
        /// Base URL for the NFT Marketplace REST API.
        static let baseURL = "https://nodeapi.techbank.live/interview/v2"

        /// API Key required for authentication.
        static let apiKey = "user-key"

        /// Default timeout interval for all network requests (seconds).
        static let timeoutInterval: TimeInterval = 30
    }

    // MARK: - Currency

    enum Currency {
        /// Ticker symbol for the purchase currency.
        static let purchaseCurrencySymbol = "USDT"

        /// Number of decimal places to display for USDT amounts.
        static let usdtDecimalPlaces = 2
    }

    // MARK: - Pagination

    enum Pagination {
        /// Default page size for marketplace listing requests.
        static let defaultPageSize = 20
    }

    // MARK: - UI

    enum UI {
        /// Animation duration used across the app for consistency.
        static let defaultAnimationDuration: Double = 0.25
    }
}
