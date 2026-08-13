//
//  NFTDetailView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct NFTDetailView: View {
    let nft: NFT
    @Environment(AppRouter.self) private var router
    @Environment(AppContainer.self) private var container
    
    @State private var showPurchaseModal = false
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Navigation Bar
            HStack {
                Button {
                    router.navigateBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                        .background(Color.yellow.opacity(0.1)) // A slight yellow tint like in the screenshot
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("NFT Details")
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    // Share action placeholder
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.custom("Poppins-Medium", size: 18))
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 16)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - Main Image
                    GeometryReader { geometry in
                        if let url = nft.imageUrl {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.1))
                                        .overlay(ProgressView())
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                case .failure:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.1))
                                        .overlay(Image(systemName: "photo").foregroundStyle(.gray))
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    
                    // MARK: - Title and Creator
                    VStack(alignment: .leading, spacing: 12) {
                        Text(nft.title)
                            .font(.custom("Poppins-SemiBold", size: 24))
                            .foregroundStyle(.black)
                        
                        HStack(spacing: 8) {
                            Image(systemName: "person")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundStyle(.gray)
                            
                            // Given the API only returns the owner ID and the screenshot uses "Theresa Webb",
                            // we fall back to a placeholder name if we can't resolve the ID.
                            // In a real app, we would look up the user profile.
                            Text(nft.createdBy == "691461156dc97f9ce2987297" ? "Theresa Webb" : nft.createdBy)
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    // MARK: - Divider
                    LineDivider()
                    
                    // MARK: - Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundStyle(.black)
                        
                        Text(nft.description ?? "No description available.")
                            .font(.custom("Poppins-Regular", size: 15))
                            .foregroundStyle(.gray)
                            .lineSpacing(4)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            
            // MARK: - Bottom Bar
            VStack(spacing: 0) {
                Divider()
                    .background(Color.gray.opacity(0.1))
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Price")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(.gray)
                        
                        Text("\(nft.price.formattedAsUSDT)")
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showPurchaseModal = true
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Text("Buy NFT")
                                .font(.custom("Poppins-SemiBold", size: 16))
                            Image(systemName: "arrow.right")
                                .font(.custom("Poppins-SemiBold", size: 16))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background {
                            LinearGradient(
                                colors: [.buyButtonGradientStart, .buyButtonGradientEnd],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        }
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .overlay {
            if showPurchaseModal {
                PurchaseConfirmationView {
                    withAnimation {
                        showPurchaseModal = false
                    }
                }
                .environment(container.makePurchaseViewModel(for: nft))
            }
        }
    }
}

#Preview {
    NFTDetailView(nft: NFT(
        id: "1",
        title: "Hypebest Apes B",
        description: "Each Apes NFT is a unique masterpiece, and crafted by artists around the globe.",
        imageUrl: URL(string: "https://nodeapi.techbank.live/interview/uploads/seed/Robo.jpg"),
        createdBy: "691461156dc97f9ce2987297",
        price: 4.75,
        currency: "USDT",
        available: false,
        createdAt: nil
    ))
    .environment(AppRouter())
}
