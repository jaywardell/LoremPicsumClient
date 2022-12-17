//
//  LoremPictureList+Picture.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension LoremPicsumList {
    
    func picture(for pictureID: Int) -> LoremPicsumPicture? {
        guard let item = item(withID: pictureID) else { return nil }
        return LoremPicsumPicture(pictureID: pictureID,
                           originalWidth: item.width,
                           originalHeight: item.height,
                           author: item.author ?? "")
    }
}
