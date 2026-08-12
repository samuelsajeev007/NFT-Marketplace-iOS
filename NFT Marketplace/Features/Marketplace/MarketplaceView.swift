//
//  MarketplaceView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct MarketplaceView: View {
    @Environment(MarketplaceViewModel.self) private var viewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(viewModel.nfts) { nft in
                    NavigationLink(value: AppRoute.nftDetail(nft: nft)) {
                        NFTCardView(nft: nft)
                    }
                    .buttonStyle(.plain)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentItem: nft)
                        }
                    }
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
            await viewModel.loadNFTs()
        }
        .task {
            if viewModel.nfts.isEmpty {
                await viewModel.loadNFTs()
            }
        }
    }
}
