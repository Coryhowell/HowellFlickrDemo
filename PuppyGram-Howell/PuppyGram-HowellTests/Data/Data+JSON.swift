//
//  Data+JSON.swift
//  PuppyGram-HowellTests
//
//  Created by Cory Howell on 3/4/22.
//

import XCTest

extension Data {
    static func fromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: "json"))
        return try Data(contentsOf: url)
    }
}

private class TestBundleClass { }
