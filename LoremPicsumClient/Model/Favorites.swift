//
//  Favorites.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/18/22.
//

import Foundation

final class Favorites {
    
    var favorites = Set<Int>()
    
    func pictureIsFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }
    
    func add(_ pictureID: Int) {
        favorites.insert(pictureID)
    }
    
    func remove(_ pictureID: Int) {
        favorites.remove(pictureID)
    }
    
}
