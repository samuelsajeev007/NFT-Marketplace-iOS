//
//  CoinCardView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct CoinCardView: View {
    let balance: WalletBalance
    
    // Helper to get correct styling for the coin icon based on the symbol
    private var iconConfig: (name: String, color: Color) {
        switch balance.symbol {
        case "BNB":
            return ("bitcoinsign.circle.fill", .yellow)
        case "ETH":
            return ("e.circle.fill", .blue)
        case "BTC":
            return ("bitcoinsign.circle.fill", .orange)
        case "USDT":
            return ("t.circle.fill", .green)
        default:
            return ("dollarsign.circle.fill", .gray)
        }
    }
    
    // Mock fiat value to match UI placeholder
    private var mockFiatValue: String {
        switch balance.symbol {
        case "BNB": return "$323245453"
        case "ETH": return "$87324545"
        case "BTC": return "$323245453"
        case "USDT": return "$87324545"
        default: return "$0"
        }
    }
    
    private var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        return formatter.string(from: balance.balance as NSDecimalNumber) ?? "0"
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Coin Icon
            Image(systemName: iconConfig.name)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(iconConfig.color, .white)
                .background(Circle().fill(Color.white))
            
            // Coin Symbol
            Text(balance.symbol)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
            
            Spacer()
            
            // Balances
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(formattedBalance) \(balance.symbol)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text(mockFiatValue)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.techbankBlue)
        }
        .padding(16)
        .background(Color.techbankBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    VStack(spacing: 12) {
        CoinCardView(balance: WalletBalance(symbol: "BNB", balance: 223))
        CoinCardView(balance: WalletBalance(symbol: "ETH", balance: 256))
    }
    .padding()
}
