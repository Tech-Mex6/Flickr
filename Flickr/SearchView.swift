//
//  SearchView.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = FlickrViewModel()
    @State private var searchQuery = ""
    @Namespace private var animationNameSpace
    
    var body: some View {
        NavigationView {
            VStack {
                let flickrImages = viewModel.images.map { item -> FlickrImage in
                    FlickrImage(
                        title: item.title ?? "No Title",
                        media: Media(m: item.media?.m ?? ""),
                        description: item.description,
                        published: item.published?.description ?? "",
                        author: item.author ?? ""
                    )
                }
                
                ImageGridView(images: flickrImages)
                    .searchable(text: $searchQuery, placement: .automatic, prompt: "Search images...")
                    .onChange(of: searchQuery) { newQuery in
                        if newQuery.isEmpty {
                            Task {
                                await viewModel.loadImages(for: "porcupine")
                            }
                        } else {
                            Task {
                                await viewModel.loadImages(for: newQuery)
                            }
                        }
                    }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .padding(.horizontal)
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Flickr Search")
            .onAppear {
                Task {
                    await viewModel.loadImages(for: "porcupine")
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
