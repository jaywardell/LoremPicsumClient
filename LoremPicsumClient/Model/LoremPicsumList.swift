//
//  LoremPicsumList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation
import Combine

final class LoremPicsumList: ObservableObject {
    
    struct ListItem: Decodable {
        let id: String
        let author: String?
        let width: Int
        let height: Int
        let url: URL?
        let downloadURL: URL?
        
        var pictureID: Int { Int(id)! }
        
//        {
//                "id": "0",
//                "author": "Alejandro Escamilla",
//                "width": 5616,
//                "height": 3744,
//                "url": "https://unsplash.com/...",
//                "download_url": "https://picsum.photos/..."
//        }

    }
    
    // many thanks to Donny Wals for this approach
    // https://www.donnywals.com/implementing-an-infinite-scrolling-list-with-swiftui-and-combine/

    @Published var items = [ListItem]()
    @Published var isLoadingPage = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    private var itemsPerPage: Int { 10 }
    private var itemsBeforeReload: Int { 3 }

    init() {
        loadMoreContent()
    }
        
    func indexForItem(withID id: Int) -> Int? {
        items.firstIndex { $0.pictureID == id }
    }
    
    func item(withID id: Int) -> ListItem? {
        items.first { $0.pictureID == id }
    }

    func loadMoreContentIfNeeded(currentItem id: Int?) {
      guard let id = id else {
        loadMoreContent()
        return
      }

      let thresholdIndex = items.index(items.endIndex, offsetBy: -itemsBeforeReload)
      if indexForItem(withID: id) == thresholdIndex {
        loadMoreContent()
      }
    }

    private var loading: AnyCancellable?
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else { return }
                
        isLoadingPage = true
        
        func received(items: [ListItem]) {
            canLoadMorePages = !items.isEmpty
            isLoadingPage = false
            currentPage += 1
        }

        let url = LoremPicsum.list(page: currentPage, picturesPerPage: itemsPerPage)
        loading = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ListItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: received(items:))
            .map { self.items + $0 }
            .catch { error in
                print("Error loading list from \(url): \(error)")
                return Just(self.items) }
            .sink { received in
                self.items = received
            }
    }
}
