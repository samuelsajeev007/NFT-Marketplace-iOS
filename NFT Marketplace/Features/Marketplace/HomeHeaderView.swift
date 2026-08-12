//
//  HomeHeaderView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack {
            Text("TECHBANK")
                .font(.system(size: 22, weight: .heavy, design: .default))
                .foregroundStyle(Color.techbankPurple)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    HomeHeaderView()
}
