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
                
                Text("\(image.description ?? "No description")")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .padding([.leading, .trailing])
                
                Text("Author: \(image.author)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing])
                
                if let publishedDate = DateFormatter.yourDateFormatter.date(from: image.published) {
                    Text("Published on: \(publishedDate, formatter: DateFormatter.yourDateFormatter)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                }
                
                if let description = image.description {
                    let components = description.split(separator: " ")
                    if let width = components.first(where: { $0.starts(with: "Width") }),
                       let height = components.first(where: { $0.starts(with: "Height") }) {
                        Text("Width: \(width), Height: \(height)")
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding([.leading, .trailing])
                    }
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
}

