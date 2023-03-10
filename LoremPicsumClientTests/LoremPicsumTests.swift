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
    
    func test_infoForPictureWith_id_returns_expected_URL() {
        let sut = LoremPicsum.self
        let id = 125
        let expected = URL(string: "https://picsum.photos/id/125/info")

        let created = sut.infoForPicture(id: id)
        XCTAssertEqual(created, expected)
    }
    
    func test_infoForPictureWith_seed_returns_expected_URL() {
        let sut = LoremPicsum.self
        let seed = "picsum"
        let expected = URL(string: "https://picsum.photos/seed/picsum/info")

        let created = sut.infoForPicture(seed: seed)
        XCTAssertEqual(created, expected)
    }

    func test_list_returns_expected_URL() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/v2/list?page=10&limit=100")

        let created = sut.list(page: 10, picturesPerPage: 100)
        XCTAssertEqual(created, expected)
    }

    
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
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
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
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
    }
    
    func test_picture_returns_the_expected_URL_when_given_2_dimensions() {
        let sut = LoremPicsum.self
        let id = 237
        let expected = URL(string: "https://picsum.photos/id/237/200/300")
        
        let created = sut.picture(id:id, width: 200, height: 300)
        XCTAssertEqual(created.id, id)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertNil(created.seed)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
    }
    
    func test_picture_returns_the_expected_URL_when_given_1_dimension() {
        let sut = LoremPicsum.self
        let id = 237
        let expected = URL(string: "https://picsum.photos/id/237/200")
        
        let created = sut.picture(id:237, width: 200)
        XCTAssertEqual(created.id, id)
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 200)
        XCTAssertNil(created.seed)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
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
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
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
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
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
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
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
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
   }
    
    func test_blur_works_on_grayscale_items() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/id/870/200/300?grayscale&blur=2")
        let base = sut.picture(id: 870, width: 200, height: 300)
        
        let created = base
            .grayscale()
            .blur(radius: 2)
        
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssert(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 2)
        XCTAssertNil(created.randomID)
        XCTAssertNil(created.fileType)
   }
    
    func test_randomID_returns_expected_url() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300?random=clue")
        let id = "clue"
        let base = sut.randomPicture(width: 200, height: 300)
        
        let created = base.randomID(id)
        
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.randomID, id)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssertFalse(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
        XCTAssertNil(created.fileType)
    }
    
    func test_jpg_returns_expected_url() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300.jpg?grayscale")
        
        let base = sut.randomPicture(width: 200, height: 300)
            .grayscale()
        
        let created = base.jpg()
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.fileType, .jpeg)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssert(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
    }
    
    func test_webp_returns_expected_url() {
        let sut = LoremPicsum.self
        let expected = URL(string: "https://picsum.photos/200/300.webp?grayscale")
        
        let base = sut.randomPicture(width: 200, height: 300)
            .grayscale()
        
        let created = base.webp()
        XCTAssertEqual(created.url, expected)
        XCTAssertEqual(created.fileType, .webP)
        XCTAssertEqual(created.width, 200)
        XCTAssertEqual(created.height, 300)
        XCTAssert(created.isGrayscale)
        XCTAssertEqual(created.blurRadius, 0)
    }

}
