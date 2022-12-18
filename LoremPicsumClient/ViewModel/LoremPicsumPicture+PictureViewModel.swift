//
//  LoremPicsumPicture+PictureViewModel.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension LoremPicsumPicture: PictureViewModel {
    func pictureURL(size: CGSize) -> URL {
        var endpoint = LoremPicsum.picture(id: pictureID, width: Int(size.width), height: Int(size.height))
        if grayscale {
            endpoint = endpoint.grayscale()
        }
        if let blur = blur {
            endpoint = endpoint.blur(radius: blur)
        }
        return endpoint.url
    }
    
    var pictureSize: CGSize {
        CGSize(width: Int(originalWidth), height: Int(originalHeight))
    }
    
    
}
