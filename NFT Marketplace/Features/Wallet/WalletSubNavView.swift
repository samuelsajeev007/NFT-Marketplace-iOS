//
//  WalletSubNavView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

enum WalletTab: String, CaseIterable {
    case myNFTs = "My NFTs"
    case coins = "Coins"
}

struct WalletSubNavView: View {
    @Binding var selectedTab: WalletTab
    
    var body: some View {
        HStack {
            // Pill toggles
            HStack(spacing: 0) {
                ForEach(WalletTab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation {
                            selectedTab = tab
                        }
                    } label: {
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(selectedTab == tab ? .white : .black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background {
                                if selectedTab == tab {
                                    Color.techbankBlue
                                } else {
                                    Color.clear
                                }
                            }
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .background(Color.gray.opacity(0.15))
            .clipShape(Capsule())
            
            Spacer()
            
            // Create NFT Button
            Button {
                // Action to create NFT
            } label: {
                Text("Create NFT")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.techbankBlue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay(
                        Capsule()
                            .stroke(Color.techbankBlue, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    WalletSubNavView(selectedTab: .constant(.myNFTs))
}
