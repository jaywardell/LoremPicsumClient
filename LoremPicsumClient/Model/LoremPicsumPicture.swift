//
//  LoremPicsumPicture.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

final class LoremPicsumPicture: ObservableObject {
    
    let pictureID: Int
    let originalWidth: Int
    let originalHeight: Int
    let author: String
    
    init(pictureID: Int,
         originalWidth: Int,
         originalHeight: Int,
         author: String) {
        self.pictureID = pictureID
        self.originalWidth = originalWidth
        self.originalHeight = originalHeight
        self.author = author
    }
}
