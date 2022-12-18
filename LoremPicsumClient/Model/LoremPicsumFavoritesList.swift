//
//  LoremPicsumFavoritesList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/18/22.
//

import Foundation
import Combine

final class LoremPicsumFavoritesList: ObservableObject, LoremPicsumPictureSource {

    // many thanks to Donny Wals for this approach
    // https://www.donnywals.com/implementing-an-infinite-scrolling-list-with-swiftui-and-combine/

    @Published var items = [ListItem]()

    let favorites: Favorites
    
    
    private var subscriptions = Set<AnyCancellable>()
    init(favorites: Favorites) {
        self.favorites = favorites
        
        reloadContent()
        
        favorites.updated.sink { [weak self] in
            self?.reloadContent()
        }
        .store(in: &subscriptions)
    }

    private func reloadContent() {
        items.removeAll()
        
        for id in favorites.favorites {
            let url = LoremPicsum.infoForPicture(id: id)
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: ListItem.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .map { (self.items + [$0]).sorted { $0.pictureID < $1.pictureID } }
                .catch { error in
                    print("Error loading list from \(url): \(error)")
                    return Just(self.items) }
                .assign(to: &$items)
        }
    }
    
//    func loadMoreContentIfNeeded(currentItem id: Int?) {
        
//        reloadContent()
        
//      guard let id = id else {
//        loadMoreContent()
//        return
//      }
//
//      let thresholdIndex = items.index(items.endIndex, offsetBy: -itemsBeforeReload)
//      if indexForItem(withID: id) == thresholdIndex {
//        loadMoreContent()
//      }
//    }

//    private func loadMoreContent() {
//        guard !isLoadingPage && canLoadMorePages else { return }
//
//        isLoadingPage = true
//
//        func received(items: [ListItem]) {
//            canLoadMorePages = !items.isEmpty
//            isLoadingPage = false
//            currentPage += 1
//        }
//
//        let url = LoremPicsum.list(page: currentPage, picturesPerPage: itemsPerPage)
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: [ListItem].self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .handleEvents(receiveOutput: received(items:))
//            .map { self.items + $0 }
//            .catch { error in
//                print("Error loading list from \(url): \(error)")
//                return Just(self.items) }
//            .assign(to: &$items)
//    }
}
