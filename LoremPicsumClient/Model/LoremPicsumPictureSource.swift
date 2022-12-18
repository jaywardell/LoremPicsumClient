//
//  LoremPicsumPictureSource.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/18/22.
//

import Foundation

struct ListItem: Decodable {
    let id: String
    let author: String?
    let width: Int
    let height: Int
    let url: URL?
    let downloadURL: URL?
    
    var pictureID: Int { Int(id)! }
    
    // JSON:
    //{
    //        "id": "0",
    //        "author": "Alejandro Escamilla",
    //        "width": 5616,
    //        "height": 3744,
    //        "url": "https://unsplash.com/...",
    //        "download_url": "https://picsum.photos/..."
    //}

}

protocol LoremPicsumPictureSource {
    
    var items: [ListItem] { get }
    var favorites: Favorites { get }
}

extension LoremPicsumPictureSource {
    
    func indexForItem(withID id: Int) -> Int? {
        items.firstIndex { $0.pictureID == id }
    }
    
    func item(withID id: Int) -> ListItem? {
        items.first { $0.pictureID == id }
    }

    func picture(for pictureID: Int) -> LoremPicsumPicture? {
        guard let item = item(withID: pictureID) else { return nil }
        return LoremPicsumPicture(pictureID: pictureID,
                           originalWidth: item.width,
                           originalHeight: item.height,
                           author: item.author ?? "",
                                  sourceURL: item.url,
                                  favorites: favorites)
    }
}
