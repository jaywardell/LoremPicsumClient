//
//  LoremPicsumTests.swift
//  LoremPicsumClientTests
//
//  Created by Joseph Wardell on 12/17/22.
//

import XCTest

@testable
import LoremPicsumClient

final class LoremPicsumTests: XCTestCase {

    func test_random_returns_expected_url_when_given_2_dimensions() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300")

        let found = sut.random(width: 200, height: 300)
        XCTAssertEqual(found, expected)
    }
    
    func test_random_returns_expected_url_when_given_1_dimension() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200")

        let found = sut.random(square: 200)
        XCTAssertEqual(found, expected)
    }

}
