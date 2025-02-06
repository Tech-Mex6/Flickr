//
//  FlickrViewModel.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//
import SwiftUI

@MainActor
class FlickrViewModel: ObservableObject {
    @Published var images: [Item] = []
    @Published var isLoading: Bool
    @Published var errorMessage: CustomError? = nil  // Use the CustomError type
    private let apiService = FlickrNetworkManager()
    
    init( isLoading: Bool) {
        self.isLoading = isLoading
    }

    func loadImages(for query: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let fetchedImages = try await apiService.fetchImages(query)
            let filteredImages = apiService.filterImages(images: fetchedImages, query: query)

            DispatchQueue.main.async {
                self.images = filteredImages
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = CustomError(message: "Failed to load images: \(error.localizedDescription)")
            }
        }
    }
}
