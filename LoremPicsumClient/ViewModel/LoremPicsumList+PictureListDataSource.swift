//
//  LoremPicsumList+PictureList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension LoremPicsumList: PictureListDataSource {
    // NOTE: most of the compliance for PictureListDataSource is actually covered by methods in LoremPicsumPictureSource
    
    func loadMoreIfPossible(currentID: Int) {
        loadMoreContentIfNeeded(currentItem: currentID)
    }
}
