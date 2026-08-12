//
//  ProfileCardView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct ProfileCardView: View {
    let userName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Image(systemName: "person")
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .frame(width: 36, height: 36)
                .background(Color.white.opacity(0.8))
                .clipShape(Circle())
            
            Text(userName)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background {
            LinearGradient(
                colors: [.profileCardGradientStart, .profileCardGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            // Adding a subtle grid overlay to mimic the screenshot
            .overlay {
                Image(systemName: "square.grid.3x3.fill")
                    .resizable(resizingMode: .tile)
                    .foregroundStyle(.white.opacity(0.1))
                    .scaleEffect(3.0)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal)
    }
}

#Preview {
    ProfileCardView(userName: "Jane Cooper")
}
