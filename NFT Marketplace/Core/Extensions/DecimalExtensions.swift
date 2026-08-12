//
//  DecimalExtensions.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation

extension Decimal {

    // MARK: - Currency Formatting

    /// Formats the decimal as a USDT currency string.
    ///
    /// Example: `Decimal(1234.5)` → `"1,234.50 USDT"`
    var formattedAsUSDT: String {
        formatted(currencyCode: AppConstants.Currency.purchaseCurrencySymbol)
    }

    /// Formats the decimal as a currency string for the given currency code.
    ///
    /// - Parameter currencyCode: ISO 4217 currency code or ticker symbol.
    func formatted(currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = AppConstants.Currency.usdtDecimalPlaces
        formatter.maximumFractionDigits = AppConstants.Currency.usdtDecimalPlaces
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true

        let numberString = formatter.string(from: self as NSDecimalNumber) ?? "\(self)"
        return "\(numberString) \(currencyCode)"
    }
}
