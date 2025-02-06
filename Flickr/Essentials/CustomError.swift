//
//  CustomError.swift
//  Flickr
//
//  Created by meekam okeke on 2/5/25.
//
import Foundation

struct CustomError: Identifiable, Error {
    var id = UUID()
    var message: String
}
