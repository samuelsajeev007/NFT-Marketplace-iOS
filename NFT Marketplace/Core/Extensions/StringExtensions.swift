//
//  StringExtensions.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

extension String {

    // MARK: - Validation

    /// Returns `true` if the string is non-empty after trimming whitespace.
    var isNotBlank: Bool {
        !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Truncation

    /// Truncates the string to the given length, appending an ellipsis if needed.
    ///
    /// - Parameter maxLength: The maximum number of characters before truncating.
    func truncated(to maxLength: Int) -> String {
        guard count > maxLength else { return self }
        return String(prefix(maxLength)) + "…"
    }
}
