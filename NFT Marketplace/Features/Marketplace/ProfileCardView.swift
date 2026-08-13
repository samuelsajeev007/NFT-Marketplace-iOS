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
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: "person")
                .font(.custom("Poppins-Medium", size: 14))
                .foregroundStyle(.black)
                .frame(width: 28, height: 28)
                .background(Color.white)
                .clipShape(Circle())
            
            Text(userName)
                .font(.custom("Poppins-Medium", size: 24))
                .frame(width: 156, height: 36, alignment: .leading)
                .minimumScaleFactor(0.5)
                .foregroundStyle(Color(red: 17/255.0, green: 20/255.0, blue: 28/255.0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, 42)
        .padding(.leading, 20)
        .frame(height: 155)
        .background {
            LinearGradient(
                colors: [
                    Color(red: 75/255.0, green: 90/255.0, blue: 252/255.0),
                    Color(red: 156/255.0, green: 66/255.0, blue: 254/255.0)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            .opacity(0.28)
            .overlay {
                Canvas { context, size in
                    let step: CGFloat = 8
                    let dotSize: CGFloat = 2
                    
                    for x in stride(from: 0, through: size.width, by: step) {
                        for y in stride(from: 0, through: size.height, by: step) {
                            let rect = CGRect(x: x, y: y, width: dotSize, height: dotSize)
                            context.fill(Path(rect), with: .color(.white.opacity(0.4)))
                        }
                    }
                }
                .mask {
                    LinearGradient(
                        colors: [.white, .white.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 16)
    }
}

#Preview {
    ProfileCardView(userName: "Jane Cooper")
}
