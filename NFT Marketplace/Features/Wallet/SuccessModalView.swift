//
//  SuccessModalView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI

struct SuccessModalView: View {
    let title: String
    let message: String
    var buttonTitle: String = "View NFT"
    var showArrow: Bool = true
    var action: () -> Void
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    action()
                }
            
            VStack {
                Spacer()
                
                // Bottom sheet content
                VStack(spacing: 24) {
                    // Success Icon
                    Image("successImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(.top, 40)
                    
                    // Text content
                    VStack(spacing: 8) {
                        Text(title)
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .foregroundStyle(.black)
                        
                        Text(message)
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundStyle(Color(red: 151/255.0, green: 151/255.0, blue: 150/255.0))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    
                    // Action Button
                    Button {
                        action()
                    } label: {
                        HStack(spacing: 12) {
                            Text(buttonTitle)
                                .font(.custom("Poppins-Medium", size: 16))
                            if showArrow {
                                Image(systemName: "arrow.right")
                                    .font(.custom("Poppins-Medium", size: 16))
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 174, height: 56)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 58/255.0, green: 108/255.0, blue: 244/255.0),
                                    Color(red: 14/255.0, green: 195/255.0, blue: 244/255.0)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 68, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: -10)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    SuccessModalView(
        title: "NFT Created Successfully!",
        message: "Your NFT is now visible in the My NFTs tab",
        action: {}
    )
}
