//
//  LoremPicsumPictureSource.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/18/22.
//

import Foundation

protocol LoremPicsumPictureSource {
    func picture(for pictureID: Int) -> LoremPicsumPicture?
}
