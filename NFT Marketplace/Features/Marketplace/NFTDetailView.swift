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
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                        .background(Color(red: 246/255.0, green: 251/255.0, blue: 231/255.0).opacity(0.35))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("NFT Details")
                    .font(.custom("Poppins-Medium", size: 24))
                    .foregroundStyle(Color(red: 17/255.0, green: 20/255.0, blue: 28/255.0))
                    .frame(width: 124, height: 28, alignment: .center)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Button {
                    shareNFT()
                } label: {
                    Image("shareIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)
            .padding(.bottom, 16)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - Main Image
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
                        .frame(width: 345, height: 364.9678)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 345, height: 364.9678)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    
                    // MARK: - Title and Creator
                    VStack(alignment: .leading, spacing: 10) {
                        Text(nft.title)
                            .font(.custom("Poppins-Medium", size: 20))
                            .foregroundStyle(Color(red: 23/255.0, green: 24/255.0, blue: 22/255.0))
                            .frame(width: 207, height: 30, alignment: .leading)
                            .minimumScaleFactor(0.5)
                        
                        HStack(spacing: 3) {
                            Image(systemName: "person")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundStyle(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0))
                            
                            Text(nft.createdBy == "691461156dc97f9ce2987297" ? "Theresa Webb" : nft.createdBy)
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundStyle(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0))
                                .frame(width: 101, height: 21, alignment: .leading)
                                .minimumScaleFactor(0.5)
                        }
                    }
                    
                    // MARK: - Divider
                    Canvas { context, size in
                        var path = Path()
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: size.width, y: 0))
                        context.stroke(path, with: .color(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0).opacity(0.55)), style: StrokeStyle(lineWidth: 0.75, dash: [5, 5]))
                    }
                    .offset(y: -10)
                    .frame(width: 345, height: 1)
                    
                    // MARK: - Description
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Description")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundStyle(Color(red: 23/255.0, green: 24/255.0, blue: 22/255.0))
                            .frame(width: 167, height: 24, alignment: .leading)
                            .offset(y: -20)
                        
                        Text(nft.description ?? "No description available.")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0))
                            .lineSpacing(14 * 0.5) // 150% line height
                            .frame(width: 345, height: 42, alignment: .leading)
                            .offset(y: -20)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            
            // MARK: - Bottom Bar
//            VStack(spacing: 0) {
//                HStack(spacing: 0) {
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text("Price")
//                            .font(.custom("Poppins-Regular", size: 14))
//                            .foregroundStyle(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0))
//                            .frame(width: 34, height: 17, alignment: .leading)
//                        
//                        Text("\(nft.price.formattedAsUSDT)")
//                            .font(.custom("Poppins-SemiBold", size: 20))
//                            .foregroundStyle(Color(red: 23/255.0, green: 24/255.0, blue: 22/255.0))
//                            .frame(width: 97, height: 30, alignment: .leading)
//                    }
//                    
//                    Spacer()
//                    
//                    Button {
//                        withAnimation {
//                            showPurchaseModal = true
//                        }
//                    } label: {
//                        HStack(spacing: 12) {
//                            Text("Buy NFT")
//                                .font(.custom("Poppins-Medium", size: 16))
//                                .frame(width: 63, height: 24)
//                            Image(systemName: "arrow.right")
//                                .font(.custom("Poppins-Medium", size: 16))
//                        }
//                        .foregroundStyle(.white)
//                        .frame(width: 157, height: 56)
//                        .background {
//                            LinearGradient(
//                                colors: [
//                                    Color(red: 58/255.0, green: 108/255.0, blue: 244/255.0),
//                                    Color(red: 14/255.0, green: 195/255.0, blue: 244/255.0)
//                                ],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        }
//                        .clipShape(RoundedRectangle(cornerRadius: 68, style: .continuous))
//                    }
//                }
//                .padding(.top, 16)
//                .padding(.trailing, 32)
//                .padding(.bottom, 39)
//                .padding(.leading, 23)
//                .frame(width: 393, height: 111)
//                .background {
//                    LinearGradient(
//                        colors: [
//                            .white,
//                            .white.opacity(0.9)
//                        ],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                }
//                .shadow(color: Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0).opacity(0.14), radius: 30, x: 0, y: 5)
//            }
            // MARK: - Bottom Bar
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Price")
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0))
                            .frame(width: 34, height: 17, alignment: .leading)
                        
                        Text("\(nft.price.formattedAsUSDT)")
                            .font(.custom("Space Grotesk", size: 20))
                            .foregroundStyle(Color(red: 23/255.0, green: 24/255.0, blue: 22/255.0))
                            .frame(width: 100, height: 30, alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showPurchaseModal = true
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Text("Buy NFT")
                                .font(.custom("Poppins-Medium", size: 16))
                                .frame(width: 63, height: 24)
                            Image(systemName: "arrow.right")
                                .font(.custom("Poppins-Medium", size: 16))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 157, height: 56)
                        .background {
                            LinearGradient(
                                colors: [
                                    Color(red: 58/255.0, green: 108/255.0, blue: 244/255.0),
                                    Color(red: 14/255.0, green: 195/255.0, blue: 244/255.0)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 68, style: .continuous))
                    }

                }
                .padding(.top, 16)
                .padding(.trailing, 32)
                .padding(.bottom, 39)
                .padding(.leading, 23)
                .frame(width: 393, height: 111)
                .background {
                    LinearGradient(
                        colors: [
                            .white,
                            .white.opacity(0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .shadow(
                    color: Color(
                        red: 151/255.0,
                        green: 151/255.0,
                        blue: 150/255.0
                    ).opacity(0.14),
                    radius: 30,
                    x: 0,
                    y: 5
                )
            }
            .offset(y: 30)
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
    
    private func shareNFT() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else { return }
        
        let shareText = "Check out this awesome NFT: \(nft.title) for \(nft.price.formattedAsUSDT)!"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = rootVC.view
            popoverController.sourceRect = CGRect(x: rootVC.view.bounds.midX, y: rootVC.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        rootVC.present(activityVC, animated: true)
    }
}

#Preview {
    let container = AppContainer()
    return NFTDetailView(nft: NFT(
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
    .environment(container.appRouter)
    .environment(container)
}
