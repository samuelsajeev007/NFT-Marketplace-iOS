//
//  WalletView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct WalletView: View {
    @Environment(WalletViewModel.self) private var viewModel
    @State private var selectedTab: WalletTab = .myNFTs
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            WalletSubNavView(selectedTab: $selectedTab)
            
            if selectedTab == .myNFTs {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.ownedNFTs) { nft in
                            NavigationLink(value: AppRoute.nftDetail(nft: nft)) {
                                NFTCardView(nft: nft)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .refreshable {
                    await viewModel.loadWalletData()
                }
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.balances) { balance in
                            CoinCardView(balance: balance)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .refreshable {
                    await viewModel.loadWalletData()
                }
            }
        }
        .task {
            if viewModel.ownedNFTs.isEmpty {
                await viewModel.loadWalletData()
            }
        }
    }
}
