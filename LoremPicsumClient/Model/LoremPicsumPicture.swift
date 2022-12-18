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
        
        // start out with a scaled image smaller than maxStartingDimension in both dimensions
        let maxStartingSize = CGSize(width: 800, height: 600)
        var size = CGSize(width: CGFloat(originalWidth), height: CGFloat(originalHeight))
        if size.width > maxStartingSize.width {
            let scalar = maxStartingSize.width / size.width
            size = CGSize(width: maxStartingSize.width, height: size.height * scalar)
        }
        if size.height > maxStartingSize.height {
            let scalar = maxStartingSize.height / size.height
            size = CGSize(width: size.width * scalar, height: maxStartingSize.height)
        }

        self.width = Int(size.width)
        self.height = Int(size.height)
        
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
    }
}
