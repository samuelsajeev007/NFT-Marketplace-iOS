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
                .font(.system(size: 19.9, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 74/255.0, green: 90/255.0, blue: 252/255.0),
                            Color(red: 158/255.0, green: 65/255.0, blue: 254/255.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 114, height: 24, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    HomeHeaderView()
}
