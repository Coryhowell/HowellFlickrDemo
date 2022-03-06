//
//  Error.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/4/22.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network: return "An error occured while fetching data"
        case .decoding: return "An error occured while decoding data"
        }
    }
}
