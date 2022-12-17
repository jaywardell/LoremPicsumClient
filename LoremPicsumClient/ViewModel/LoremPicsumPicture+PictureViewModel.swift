//
//  LoremPicsumPicture+PictureViewModel.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension LoremPicsumPicture: PictureViewModel {
    func pictureURL(size: CGSize) -> URL {
        LoremPicsum.picture(id: pictureID, width: Int(size.width), height: Int(size.height)).url
    }
    
    var pictureSize: CGSize {
        CGSize(width: Int(originalWidth), height: Int(originalHeight))
    }
    
    
}
