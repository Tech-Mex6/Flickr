//
//  ImageGridView.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//
import SwiftUI

struct ImageGridView: View {
    let images: [FlickrImage]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(images) { image in
                NavigationLink(destination: ImageDetailView(image: image)) {
                    AsyncImage(url: URL(string: image.imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "photo.fill")
                                .accessibilityLabel("placeholder image")
                               
                        case .success(let image):
                                image.resizable()
                                .scaledToFill()
                                .clipped()
            
                        case .failure(_):
                            Image(systemName:"photo.badge.exclamationmark")
                                .accessibilityLabel("Image failed to load")
            
                       default:
                            EmptyView()
                        }
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    .accessibilityLabel(image.title)
                }
            }
        }
    }
}
