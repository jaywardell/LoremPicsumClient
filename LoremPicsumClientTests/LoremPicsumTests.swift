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

    func test_randomPicture_returns_expected_url_when_given_2_dimensions() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300")

        let found = sut.randomPicture(width: 200, height: 300)
        XCTAssertEqual(found, expected)
    }
    
    func test_randomPicture_returns_expected_url_when_given_1_dimension() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200")

        let found = sut.randomPicture(square: 200)
        XCTAssertEqual(found, expected)
    }

    func test_picture_returns_the_expected_URL_when_given_2_dimensions() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/id/237/200/300")

        let found = sut.picture(id:237, width: 200, height: 300)
        XCTAssertEqual(found, expected)

    }
    
}
