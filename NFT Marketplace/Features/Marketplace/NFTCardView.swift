//
//  NFTCardView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct NFTCardView: View {
    let nft: NFT
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image container
            GeometryReader { geometry in
                if let url = nft.imageUrl {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .overlay {
                                    ProgressView()
                                }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .overlay {
                                    Image(systemName: "photo")
                                        .foregroundStyle(.gray)
                                }
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(.gray)
                        }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            
            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(nft.title)
                    .font(.custom("Poppins-Medium", size: 13.02))
                    .kerning(0.93)
                    .frame(height: 20)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                
                Text("\(nft.price.formattedAsUSDT)")
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .kerning(0.93)
                    .frame(height: 21)
                    .foregroundStyle(Color.techbankBlue)
            }
            .padding(.horizontal, 4)
        }
    }
}
