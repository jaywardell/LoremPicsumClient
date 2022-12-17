//
//  LoremPicsum.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

enum LoremPicsum {
    // see https://picsum.photos for documenation on the API for LoremPicsum

    static func randomPicture(width: Int, height: Int) -> URL {
        URL(string: "https://picsum.photos/\(width)/\(height)")!
    }
    
    static func random(square width: Int) -> URL {
        URL(string: "https://picsum.photos/\(width)")!
    }

    static func picture(id: Int, width: Int, height: Int) -> URL {
        URL(string: "https://picsum.photos/id/\(id)/\(width)/\(height)")!
    }
    
}
