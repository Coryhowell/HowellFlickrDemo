//
//  FlickrDataTests.swift
//  PuppyGram-HowellTests
//
//  Created by Cory Howell on 3/4/22.
//

import XCTest
@testable import PuppyGram_Howell

class FlickrDataTests: XCTestCase, DecodableTestCase {
    var dictionary: NSDictionary!
    var sut: Puppy!
    
    override func setUp() {
        try! givenSUTFromJSON(fileName: "FlickrData")
    }
    
    override func tearDown() {
        dictionary = nil
        sut = nil
    }
    
    func testConformsToDecodable() {
        XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func testCodableSetsTitle() throws {
        try XCTAssertEqualToAny(sut.title, dictionary["title"])
    }
    
    func testCodableSetsPublished() throws {
        try XCTAssertEqualToAny(sut.published, dictionary["published"])
    }

    
    func testFormattedDate() {
        XCTAssertEqual(sut.formattedPublishedDate, "2/4/2022, 10:51 PM")
    }
}
