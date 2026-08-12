//
//  CustomSegmentedControl.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

enum HomeTab: String, CaseIterable {
    case marketplace = "Marketplace"
    case myWallets = "My Wallets"
}

struct CustomSegmentedControl: View {
    @Binding var selectedTab: HomeTab
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(HomeTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 12) {
                        Text(tab.rawValue)
                            .font(.system(size: 16, weight: selectedTab == tab ? .medium : .regular))
                            .foregroundStyle(selectedTab == tab ? .black : .gray)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                            
                            if selectedTab == tab {
                                Rectangle()
                                    .fill(Color.techbankBlue)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 16)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
        }
    }
}

#Preview {
    CustomSegmentedControl(selectedTab: .constant(.marketplace))
}
