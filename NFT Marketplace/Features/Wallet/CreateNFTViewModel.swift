//
//  CreateNFTViewModel.swift
//  NFT Marketplace
//
//  Created by Samuel Sajeev on 12/08/26.
//

import Foundation
import Observation
import SwiftUI
import PhotosUI

@MainActor
@Observable
final class CreateNFTViewModel {
    
    // MARK: - Form State
    
    var title: String = ""
    var description: String = ""
    var sellingPrice: String = ""
    
    // Image selection state
    var selectedItem: PhotosPickerItem?
    var selectedImageData: Data?
    
    // UI State
    private(set) var isLoading: Bool = false
    private(set) var showSuccessModal: Bool = false
    private(set) var errorMessage: String?
    
    var isFormValid: Bool {
        !title.isEmpty && !description.isEmpty && !sellingPrice.isEmpty && selectedImageData != nil
    }
    
    // MARK: - Dependencies
    
    private let walletRepository: WalletRepositoryProtocol
    
    // MARK: - Init
    
    init(walletRepository: WalletRepositoryProtocol) {
        self.walletRepository = walletRepository
    }
    
    // MARK: - Actions
    
    func uploadNFT() async {
        guard isFormValid, let imageData = selectedImageData else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await walletRepository.uploadNFT(
                imageData: imageData,
                imageName: "nft_image.jpg",
                title: title,
                description: description,
                price: sellingPrice,
                userId: "user-001",
                email: "jane.cooper@example.com"
            )
            
            // Upload successful, show modal
            showSuccessModal = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func dismissModal() {
        showSuccessModal = false
    }
}
