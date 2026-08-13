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
                            .font(.custom(selectedTab == tab ? "Poppins-Medium" : "Poppins", size: 16))
                            .foregroundStyle(.black)
//                            .frame(width: tab == .marketplace ? 94 : 79, height: 18)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 3)
                            
                            if selectedTab == tab {
                                Rectangle()
                                    .fill(Color(red: 51/255.0, green: 137/255.0, blue: 251/255.0))
                                    .frame(width: 174, height: 3)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
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
