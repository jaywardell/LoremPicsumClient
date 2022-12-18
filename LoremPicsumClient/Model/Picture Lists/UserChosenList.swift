//
//  UserChosenList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/18/22.
//

import Foundation
import Combine


enum Filter: String, CaseIterable, Hashable { case all, favorites }

final class UserChosenList: ObservableObject {
    
    let allList: LoremPicsumList
    let favoritesList: LoremPicsumFavoritesList

    @Published var filter: Filter = .all
    
    private var subscriptions = Set<AnyCancellable>()
    init(favorites: Favorites) {
        self.allList = LoremPicsumList(favorites: favorites)
        self.favoritesList = LoremPicsumFavoritesList(favorites: favorites)
        
        allList.objectWillChange.sink(receiveValue: objectWillChange.send)
            .store(in: &subscriptions)
        favoritesList.objectWillChange.sink(receiveValue: objectWillChange.send)
            .store(in: &subscriptions)
    }
    
    private var currentList: any PictureListDataSource {
        switch filter {
        case .all: return allList
        case .favorites: return favoritesList
        }
    }
    
    private var currentPictureSource: any LoremPicsumPictureSource {
        switch filter {
        case .all: return allList
        case .favorites: return favoritesList
        }
    }

    func picture(for pictureID: Int) -> LoremPicsumPicture? {
        currentPictureSource.picture(for: pictureID)
    }
}

extension UserChosenList: PictureListDataSource {
    
    var pictures: [Int] { currentList.pictures }
    
    func pictureURL(for pictureID: Int, size: CGSize) -> URL {
        favoritesList.pictureURL(for: pictureID, size: size)
    }
    
    func pictureSize(for pictureID: Int) -> CGSize {
        currentList.pictureSize(for: pictureID)
    }
        
    func pictureIsFavorite(_ pictureID: Int) -> Bool {
        currentList.pictureIsFavorite(pictureID)
    }

    func loadMoreIfPossible(currentID: Int) {
        currentList.loadMoreIfPossible(currentID: currentID)
    }
}
