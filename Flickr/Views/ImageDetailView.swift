//
//  ImageDetailView.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//


import SwiftUI

struct ImageDetailView: View {
    var image: FlickrImage
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: image.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .accessibilityLabel("image is loading")
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 400)
                            .cornerRadius(8)
                    case .failure(_):
                        Text("Failed to load image")
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Text(image.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                
                if let description = cleanDescription(image.description) {
                    Text(description)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .padding([.leading, .trailing])
                        .accessibilityLabel(description)
                }
                
                Text("Author: \(image.author)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing])
                    .accessibilityLabel(image.author)
                
                if let publishedDate = formatPublishedDate(image.published) {
                    Text("Published on: \(publishedDate)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                }
                
                if let (width, height) = extractDimensions(from: image.description) {
                    Text("Width: \(width), Height: \(height)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                }
            }
        }
        .navigationTitle("Image Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: "Title: \(image.title)\nDescription: \(image.description ?? "No description")\nURL: \(image.imageUrl)") {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
    }
    
    func cleanDescription(_ htmlString: String?) -> String? {
        guard let htmlString = htmlString else { return nil }
        guard let data = htmlString.data(using: .utf8) else { return nil }
        
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
            return attributedString.string.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return nil
        }
    }
    
    func formatPublishedDate(_ dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Ensure this matches API format
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: date)
        }
        return nil
    }
    
    func extractDimensions(from description: String?) -> (String, String)? {
        guard let description = description else { return nil }
        
        let widthPattern = "Width: (\\d+)"
        let heightPattern = "Height: (\\d+)"
        
        let width = extractFirstMatch(for: widthPattern, in: description)
        let height = extractFirstMatch(for: heightPattern, in: description)
        
        if let width = width, let height = height {
            return (width, height)
        }
        return nil
    }
    
    func extractFirstMatch(for pattern: String, in text: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            if let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
               let range = Range(match.range(at: 1), in: text) {
                return String(text[range])
            }
        } catch {
            return nil
        }
        return nil
    }
}

