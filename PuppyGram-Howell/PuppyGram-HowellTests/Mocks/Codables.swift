//
//  Codables.swift
//  PuppyGram-HowellTests
//
//  Created by Cory Howell on 3/4/22.
//

import Foundation

protocol DecodableTestCase: AnyObject {
    associatedtype T: Decodable
    var dictionary: NSDictionary! { get set }
    var sut: T! { get set }
}

extension DecodableTestCase {
    func givenSUTFromJSON(fileName: String = "\(T.self)") throws {
        let decoder = JSONDecoder()
        let data = try Data.fromJSON(fileName: fileName)
        dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        sut = try decoder.decode(T.self, from: data)
    }
}
