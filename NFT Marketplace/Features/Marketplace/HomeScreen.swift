//
//  HomeScreen.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab: HomeTab = .marketplace
    
    var body: some View {
        VStack(spacing: 0) {
            HomeHeaderView()
                .padding(.bottom, 16)
            
            ProfileCardView(userName: "Jane Cooper")
                .padding(.bottom, 16)
            
            CustomSegmentedControl(selectedTab: $selectedTab)
            
            // Tab Content
            TabView(selection: $selectedTab) {
                MarketplaceView()
                    .tag(HomeTab.marketplace)
                
                // Placeholder for My Wallets tab content
                VStack {
                    Text("My Wallets Content")
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tag(HomeTab.myWallets)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color.techbankBackground)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeScreen()
        .environment(MarketplaceViewModel(marketplaceRepository: MarketplaceRepository(networkService: NetworkService())))
}
