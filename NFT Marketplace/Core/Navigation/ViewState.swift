//
//  ViewState.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

// MARK: - ViewState

/// A generic state machine for async data-loading scenarios.
///
/// ViewModels can expose a `ViewState<T>` property to represent the full
/// lifecycle of a network call in a single, exhaustive enum — eliminating
/// the need for multiple Boolean flags (`isLoading`, `hasError`, etc.).
///
/// Usage:
/// ```swift
/// @Published private(set) var state: ViewState<[NFT]> = .idle
/// ```
enum ViewState<T> {

    /// No data has been requested yet.
    case idle

    /// A request is currently in progress.
    case loading

    /// The request succeeded and data is available.
    case loaded(T)

    /// The request failed with a descriptive error.
    case error(String)

    // MARK: - Convenience

    /// Returns the loaded data, or `nil` if the state is not `.loaded`.
    var data: T? {
        if case .loaded(let value) = self { return value }
        return nil
    }

    /// Returns `true` while a request is in progress.
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    /// Returns the error message, or `nil` if the state is not `.error`.
    var errorMessage: String? {
        if case .error(let message) = self { return message }
        return nil
    }
}
