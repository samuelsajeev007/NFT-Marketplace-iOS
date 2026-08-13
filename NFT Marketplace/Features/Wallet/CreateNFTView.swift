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
                            .font(.custom("Poppins-Medium", size: 20))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 44, height: 44)
                    
                    Spacer()
                    
                    Text("Create NFT")
                        .font(.custom("Poppins-SemiBold", size: 20))
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
                                        .font(.custom("Poppins-Regular", size: 40))
                                        .foregroundStyle(.gray)
                                    Text("Upload NFT")
                                        .font(.custom("Poppins-Medium", size: 16))
                                        .foregroundStyle(.black)
                                    Text("( Type : png, jpeg )")
                                        .font(.custom("Poppins-Regular", size: 12))
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
                                    if let uiImage = UIImage(data: data) {
                                        let resizedImage = uiImage.resized(toMaxDimension: 1024)
                                        if let jpegData = resizedImage.jpegData(compressionQuality: 0.7) {
                                            viewModel.selectedImageData = jpegData
                                        } else {
                                            viewModel.selectedImageData = data
                                        }
                                    } else {
                                        viewModel.selectedImageData = data
                                    }
                                }
                            }
                        }
                        
                        // Title
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Title *")
                                .font(.custom("Poppins-Medium", size: 14))
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
                                .font(.custom("Poppins-Medium", size: 14))
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
                                .font(.custom("Poppins-Medium", size: 14))
                                .foregroundStyle(.black)
                            
                            HStack {
                                TextField("Enter the amount", text: $viewModel.sellingPrice)
                                    .keyboardType(.decimalPad)
                                
                                Text("USDT")
                                    .font(.custom("Poppins-Medium", size: 14))
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
                                        .font(.custom("Poppins-SemiBold", size: 16))
                                    Image(systemName: "arrow.right")
                                        .font(.custom("Poppins-SemiBold", size: 16))
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

// MARK: - UIImage Resizing Extension
fileprivate extension UIImage {
    func resized(toMaxDimension maxDimension: CGFloat) -> UIImage {
        let size = self.size
        let widthRatio = maxDimension / size.width
        let heightRatio = maxDimension / size.height
        let scale = min(1.0, min(widthRatio, heightRatio))
        
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1.0
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
