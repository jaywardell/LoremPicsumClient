//
//  LoremPicsumPicture.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation
import UniformTypeIdentifiers

final class LoremPicsumPicture: ObservableObject {
    
    let pictureID: Int
    let originalWidth: Int
    let originalHeight: Int
    let author: String
    
    @Published var width: Int
    @Published var height: Int
    @Published var grayscale: Bool
    @Published var blur: Int?
    @Published var filetype: UTType?

    init(pictureID: Int,
         originalWidth: Int,
         originalHeight: Int,
         author: String) {
        self.pictureID = pictureID
        self.originalWidth = originalWidth
        self.originalHeight = originalHeight
        self.author = author
        
        self.width = originalWidth
        self.height = originalHeight
        
        self.grayscale = false
    }
}
