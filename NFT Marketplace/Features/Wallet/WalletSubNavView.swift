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
    @Environment(AppRouter.self) private var router
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
                            .font(.custom("Poppins-Medium", size: 14))
                            .foregroundStyle(selectedTab == tab ? .white : .black)
                            .frame(width: 90, height: 31)
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
            .frame(width: 184, height: 35)
            .background(Color(red: 237/255.0, green: 237/255.0, blue: 237/255.0))
            .clipShape(Capsule())
            
            Spacer()
            
            if selectedTab == .myNFTs {
                // Create NFT Button
                Button {
                    router.navigate(to: .createNFT)
                } label: {
                    Text("Create NFT")
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundStyle(Color.techbankBlue)
                        .frame(width: 132, height: 35)
                        .overlay(
                            Capsule()
                                .stroke(Color.techbankBlue, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    WalletSubNavView(selectedTab: .constant(.myNFTs))
}
