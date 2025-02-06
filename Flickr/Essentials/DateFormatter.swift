//
//  DateFormatter.swift
//  Flickr
//
//  Created by meekam okeke on 2/6/25.
//
import Foundation

extension DateFormatter {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

