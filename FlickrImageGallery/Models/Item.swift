//
//  Item.swift
//  FlickrImageGallery
//
//  Created by Jayakrishnan u on 9/18/24.
//

import Foundation

struct SearchResults: Decodable {
    var items: [Item]
}

struct Item: Decodable, Hashable {
    let title: String
    let media: Media
    let description: String
    let published: String
    let author: String
}

extension Item: Identifiable {
    var id: UUID { return UUID() }
}

struct Media: Decodable, Hashable {
    var m: String
}
