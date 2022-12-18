//
//  Favorites.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/18/22.
//

import Foundation

final class Favorites {
    
    var favorites = Set<Int>()
    
    init() {
        self.load()
    }
    
    func pictureIsFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }
    
    func add(_ pictureID: Int) {
        favorites.insert(pictureID)
        archive()
    }
    
    func remove(_ pictureID: Int) {
        favorites.remove(pictureID)
        archive()
    }

    static var ArchiveKey: String { "\(Self.self):\(#function)" }
    
    func archive() {
        UserDefaults.standard.set(Array(favorites), forKey: Self.ArchiveKey)
    }
    
    func load() {
        let saved = UserDefaults.standard.object(forKey: Self.ArchiveKey) as? [Int]
        self.favorites = Set(saved ?? [])
    }

}
