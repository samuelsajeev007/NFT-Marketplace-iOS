//
//  CoinCardView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct CoinCardView: View {
    let balance: WalletBalance
    

    
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
            Image(balance.symbol)
                .resizable()
                .scaledToFit()
                .scaleEffect(balance.symbol == "BTC" ? 1.35 : 1.0)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.white))
                .clipShape(Circle())
            
            // Coin Symbol
            Text(balance.symbol)
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundStyle(.black)
            
            Spacer()
            
            // Balances
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(formattedBalance) \(balance.symbol)")
                    .font(.custom("Poppins-Medium", size: 13.1))
                    .foregroundStyle(.black)
                
                Text(mockFiatValue)
                    .font(.custom("Poppins-Medium", size: 10.3))
                    .foregroundStyle(.gray)
            }
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.custom("Poppins-Medium", size: 14))
                .foregroundStyle(Color.techbankBlue)
        }
        .padding(16)
        .background(Color(red: 236/255.0, green: 245/255.0, blue: 255/255.0))
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
