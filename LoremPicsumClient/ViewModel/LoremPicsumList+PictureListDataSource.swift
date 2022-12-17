//
//  LoremPicsumList+PictureList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension LoremPicsumList: PictureListDataSource {
    var pictures: [Int] { items.map(\.pictureID) }
    
    func pictureURL(for pictureID: Int, size: CGSize) -> URL {
        return LoremPicsum.picture(id: pictureID, width: Int(size.width)).url
    }
    
    func pictureSize(for pictureID: Int) -> CGSize {
        guard let picture = item(withID: pictureID) else { return .zero }
        
        return CGSize(width: CGFloat(picture.width), height: CGFloat(picture.height))
    }
    
    func loadMoreIfPossible(currentID: Int) {
        loadMoreContentIfNeeded(currentItem: currentID)
    }
    
    
}
