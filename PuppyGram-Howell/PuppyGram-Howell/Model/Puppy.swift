//
//  Puppy.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/4/22.
//

import Foundation

struct PuppyGram: Codable {
    let puppies: [Puppy]?
    
    enum CodingKeys: String, CodingKey {
        case puppies = "items"
    }
}

struct Puppy: Codable {
    let title: String?
    let media: Media?
    let published: String?
}

struct Media: Codable {
    let m: String?
}

extension Puppy {
    ///  Example: 2/4/2022, 10:51 PM
    var formattedPublishedDate: String {
        guard let date = published?.convertISODate() else { return "" }
        return date.formatted()
    }
}


