//
//  LoremPicsumPicture.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation
import Combine
import UniformTypeIdentifiers

final class LoremPicsumPicture: ObservableObject {
    
    let pictureID: Int
    let originalWidth: Int
    let originalHeight: Int
    let author: String
    
    var width: Int { willSet { reload.send() } }
    var height: Int { willSet { reload.send() } }
    var blur: Int? { willSet { reload.send() } }
    var grayscale: Bool { willSet { quickReload.send() } }

    var filetype: UTType? { willSet { quickReload.send() } }

    // there are some properties, like blurRadius,
    // that the user will often change many times
    // in a short period of time
    // these changed should be throttled
    // to avoid excessive network traffic
    private let reload = PassthroughSubject<Void, Never>()
    
    // and then there are others that are usually changed just once
    // like grayscale, since it's a boolean
    private let quickReload = PassthroughSubject<Void, Never>()

    private(set) var editing = false
    
    private var subscriptions = Set<AnyCancellable>()
    init(pictureID: Int,
         originalWidth: Int,
         originalHeight: Int,
         author: String) {
        self.pictureID = pictureID
        self.originalWidth = originalWidth
        self.originalHeight = originalHeight
        self.author = author
        
        self.width = originalWidth
        self.height = originalHeight
        
        self.grayscale = false

        reload
            .handleEvents(receiveOutput: { [weak self] in self?.editing = true })
            .handleEvents(receiveOutput: { [weak self] in self?.objectWillChange.send() })
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .handleEvents(receiveOutput: { [weak self] in self?.editing = false })
            .sink(receiveValue: objectWillChange.send)
            .store(in: &subscriptions)

        quickReload
            .handleEvents(receiveOutput: { [weak self] in self?.objectWillChange.send() })
            .sink(receiveValue: objectWillChange.send)
            .store(in: &subscriptions)

        // start off with a display size
        // that's less than 1000
        // in each dimension
        while self.width > 1000 || self.height > 1000 {
            self.width /= 2
            self.height /= 2
        }
    }
}
