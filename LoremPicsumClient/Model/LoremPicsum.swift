//
//  LoremPicsum.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

// see https://picsum.photos for documenation on the API for LoremPicsum
enum LoremPicsum {
    
    static func random(width: Int, height: Int) -> URL {
        URL(string: "https://picsum.photos/\(width)/\(height)")!
    }
    
    static func random(square width: Int) -> URL {
        URL(string: "https://picsum.photos/\(width)")!
    }

}
