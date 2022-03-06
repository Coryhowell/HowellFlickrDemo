//
//  XCTAssertEqual.swift
//  PuppyGram-HowellTests
//
//  Created by Cory Howell on 3/6/22.
//

import XCTest

func XCTAssertEqualToAny<T: Equatable>(_ actual: @autoclosure () throws -> T, _ expected: @autoclosure () throws -> Any?, file: StaticString =  #file, line: UInt = #line) throws {
    let actual = try actual()
    let expected = try XCTUnwrap(expected() as? T)
    XCTAssertEqual(actual, expected, file: file, line: line)
}
