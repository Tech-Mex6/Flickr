//
//  FlickrAPIService.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//
import Foundation

class FlickrNetworkManager {
    
    enum CustomError: String, Error {
        case invalidURL = "URL is invalid"
        case decodingError
        case unknownError
    }
    
    func fetchImages(_ query: String) async throws -> [Item] {
        // Safely encode the query string to avoid issues with spaces or special characters
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw CustomError.invalidURL
        }
        
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(encodedQuery)"
        
        guard let url = URL(string: urlString) else {
            throw CustomError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(FlickrResponse.self, from: data)
                return response.items
            } catch {
                throw CustomError.decodingError
            }
        } catch {
            throw CustomError.unknownError
        }
    }
    
    func filterImages(images: [Item], query: String) -> [Item] {
        return images.filter { image in
            image.title?.lowercased().contains(query.lowercased()) ?? false
        }
    }
}

