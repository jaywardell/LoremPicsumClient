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

        let created = sut.randomPicture(width: 200, height: 300)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertNil(created.seed)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
    }
    
    func test_randomPicture_returns_expected_url_when_given_1_dimension() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200")

        let created = sut.randomPicture(width: 200)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 200)
        XCTAssertNil(created.seed)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
    }

    func test_picture_returns_the_expected_URL_when_given_2_dimensions() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/id/237/200/300")

        let created = sut.picture(id:237, width: 200, height: 300)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertNil(created.seed)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
   }
    
    func test_picture_returns_the_expected_URL_when_given_1_dimension() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/id/237/200")

        let created = sut.picture(id:237, width: 200)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 200)
        XCTAssertNil(created.seed)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
   }

    func test_seededPicture_returns_an_URL_with_a_unique_id() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/seed/picsum/200/300")!

        let created = sut.seededPicture(seed:"picsum", width: 200, height: 300)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
        XCTAssertEqual(created.seed, expected.pathComponents[2])
    }
    
    func test_grayscale_returns_expected_url() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300?grayscale")
        let base = sut.randomPicture(width: 200, height: 300)

        let created = base.grayscale()
        
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssert(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
   }

    func test_blur_returns_expected_url() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300?blur")
        let base = sut.randomPicture(width: 200, height: 300)

        let created = base.blur()
        
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 1)
    }

    func test_blur_respects_radius_passed_in() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300?blur=2")
        let base = sut.randomPicture(width: 200, height: 300)

        let created = base.blur(radius: 2)
        
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 2)
    }

}
