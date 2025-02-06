//
//  DataModel.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//


import Foundation

struct FlickrImage: Codable, Identifiable {
    var id = UUID()
    let title: String
    let media: Media
    let description: String?
    var published: String
    let author: String
    var imageUrl: String { media.m }
}

struct Item: Codable {
    let title: String?
    let media: Media?
    let description: String?
    let published: String?  // Change from Date? to String?
    let author, authorID, tags: String?
}

struct Media: Codable {
    let m: String
}

struct FlickrResponse: Codable {
    let items: [Item]  // This is the correct structure based on the API response
}




