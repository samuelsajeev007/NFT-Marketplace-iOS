//
//  PurchaseConfirmationView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct PurchaseConfirmationView: View {
    @Environment(PurchaseViewModel.self) private var viewModel
    
    var onDismiss: () -> Void
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack(alignment: .bottom) {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    if !viewModel.isLoading {
                        onDismiss()
                    }
                }
            
            // Bottom Sheet Content
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Text("Confirm Your Purchase")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundStyle(.black)
                    Spacer()
                    
                    Button {
                        if !viewModel.isLoading {
                            onDismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundStyle(.black)
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical, 20)
                
                Divider()
                
                // NFT Info
                HStack(spacing: 16) {
                    if let url = viewModel.nft.imageUrl {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
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
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.nft.title)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundStyle(.black)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "person")
                                .font(.custom("Poppins-Regular", size: 12))
                                .foregroundStyle(.gray)
                            // API doesn't return creator name string natively, so we mock it if it's an ID
                            Text("Theresa Webb")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                }
                .padding(20)
                
                // Dashed Line
                DashedLineShape()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .frame(height: 1)
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .padding(.horizontal, 20)
                
                // Buying Price
                VStack(alignment: .leading, spacing: 8) {
                    Text("Buying Price")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundStyle(.gray)
                    
                    Text("\(String(format: "%.2f", NSDecimalNumber(decimal: viewModel.nft.price).doubleValue)) \(viewModel.nft.currency ?? "USDT")")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                
                // Dashed Line
                DashedLineShape()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .frame(height: 1)
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .padding(.horizontal, 20)
                
                // Wallet Balance
                VStack(alignment: .leading, spacing: 8) {
                    Text("Wallet Balance")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundStyle(.gray)
                    
                    Text("\(String(format: "%.2f", NSDecimalNumber(decimal: viewModel.usdtBalance).doubleValue)) USDT")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .foregroundStyle(viewModel.hasSufficientBalance ? .black : .red)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                
                // Dashed Line
                DashedLineShape()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .frame(height: 1)
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .padding(.horizontal, 20)
                
                // Action Button
                Button {
                    Task {
                        await viewModel.purchase()
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Buy NFT")
                                .font(.custom("Poppins-SemiBold", size: 16))
                            Image(systemName: "arrow.right")
                                .font(.custom("Poppins-SemiBold", size: 16))
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 50)
                    .background(
                        LinearGradient(
                            colors: [Color.techbankBlue, Color.blue.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .opacity(viewModel.hasSufficientBalance ? 1.0 : 0.5)
                }
                .disabled(!viewModel.hasSufficientBalance || viewModel.isLoading)
                .padding(.vertical, 24)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundStyle(.red)
                        .padding(.bottom, 16)
                }
            }
            .background(Color.white)
            .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
            .ignoresSafeArea(edges: .bottom)
            .transition(.move(edge: .bottom))
            
            if viewModel.showSuccessModal {
                SuccessModalView(
                    title: "Purchase Successful!",
                    message: "View it anytime in My NFTs.",
                    buttonTitle: "Close",
                    showArrow: false
                ) {
                    viewModel.dismissModal()
                    onDismiss()
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                await viewModel.fetchBalance()
            }
        }
    }
}

struct DashedLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
