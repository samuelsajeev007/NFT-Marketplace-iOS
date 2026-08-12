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
    var action: () -> Void
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    action()
                }
            
            // Modal content
            VStack(spacing: 24) {
                
                // Success Icon
                ZStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .padding(.top, 24)
                
                // Text content
                VStack(spacing: 8) {
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                    
                    Text(message)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
                
                // Action Button
                Button {
                    action()
                } label: {
                    HStack {
                        Text("View NFT")
                            .font(.system(size: 16, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 16, weight: .semibold))
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
                }
                .buttonStyle(.plain)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: 320)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
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
