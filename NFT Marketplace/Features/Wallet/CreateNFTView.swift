//
//  CreateNFTView.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import SwiftUI
import PhotosUI

struct CreateNFTView: View {
    @Environment(AppRouter.self) private var router
    @Environment(CreateNFTViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack {
            Color.techbankBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        router.navigateBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 44, height: 44)
                    
                    Spacer()
                    
                    Text("Create NFT")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                        .padding(.trailing, 44) // Balance the back button
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Image Picker
                        PhotosPicker(selection: $viewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
                            if let imageData = viewModel.selectedImageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } else {
                                VStack(spacing: 8) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 40))
                                        .foregroundStyle(.gray)
                                    Text("Upload NFT")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                    Text("( Type : png, jpeg )")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.gray)
                                }
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                        .buttonStyle(.plain)
                        .onChange(of: viewModel.selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    viewModel.selectedImageData = data
                                }
                            }
                        }
                        
                        // Title
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Title *")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.black)
                            
                            TextField("Enter the Nft name", text: $viewModel.title)
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.black)
                            
                            TextEditor(text: $viewModel.description)
                                .frame(height: 100)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        
                        // Selling Price
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Set Selling Price *")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.black)
                            
                            HStack {
                                TextField("Enter the amount", text: $viewModel.sellingPrice)
                                    .keyboardType(.decimalPad)
                                
                                Text("USDT")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        // Submit Button
                        Button {
                            Task {
                                await viewModel.uploadNFT()
                            }
                        } label: {
                            HStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("Create NFT")
                                        .font(.system(size: 16, weight: .semibold))
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(
                                    colors: [Color.techbankBlue, Color.blue.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(Capsule())
                            .opacity(viewModel.isFormValid ? 1.0 : 0.5)
                        }
                        .disabled(!viewModel.isFormValid || viewModel.isLoading)
                        .padding(.top, 16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            
            // Error Alert
            if let error = viewModel.errorMessage {
                VStack {
                    Spacer()
                    Text(error)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .clipShape(Capsule())
                        .padding(.bottom, 40)
                }
            }
            
            // Success Modal
            if viewModel.showSuccessModal {
                SuccessModalView(
                    title: "NFT Created Successfully!",
                    message: "Your NFT is now visible in the My NFTs tab"
                ) {
                    viewModel.dismissModal()
                    router.navigateBack() // Go back to wallet after success
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
