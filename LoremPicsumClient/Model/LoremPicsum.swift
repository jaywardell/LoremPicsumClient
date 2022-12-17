//
//  LoremPicsum.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

enum LoremPicsum {
    
    static func random(width: Int, height: Int) -> URL {
        URL(string: "https://picsum.photos/\(width)/\(height)")!
    }
}
