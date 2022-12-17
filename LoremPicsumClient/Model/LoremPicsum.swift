//
//  LoremPicsum.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

struct LoremPicsum {
    
    let url: URL
    let width: CGFloat
    let height: CGFloat
    let seed: String?
    
    let isGrayscale: Bool
    
    // see https://picsum.photos for documenation on the API for LoremPicsum
    
    private static let host = "picsum.photos"
    private static var base: URLComponents {
        var out = URLComponents()
        out.host = host
        out.scheme = "https"
        return out
    }
    
    static func randomPicture(width: Int, height: Int? = nil) -> LoremPicsum {
        base
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map { LoremPicsum(url: $0, width: CGFloat(width), height: CGFloat(height ?? width), seed: nil, isGrayscale: false) }!
    }
    
    static func picture(id: Int, width: Int, height: Int? = nil) -> LoremPicsum {
        base
            .addingPathComponent("id")
            .addingPathComponent(id)
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map { LoremPicsum(url: $0, width: CGFloat(width), height: CGFloat(height ?? width), seed: nil, isGrayscale: false) }!
    }
    
    static func seededPicture(seed: String = UUID().uuidString, width: Int, height: Int? = nil) -> LoremPicsum {
        base
            .addingPathComponent("seed")
            .addingPathComponent(seed)
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height ?? width),
                            seed: seed, isGrayscale: false)
            }!
    }
    
    func grayscale() -> LoremPicsum {
        URLComponents(url: url, resolvingAgainstBaseURL: false)!
            .addingQueryItem("grayscale")
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height),
                            seed: seed, isGrayscale: true)
            }!
    }
}

// MARK: -

extension URLComponents {

    func addingPathComponent(_ string: String) -> URLComponents {
        var out = self
        out.path += "/" + string
        return out
    }
    
    func addingPathComponent(_ int: Int) -> URLComponents {
        addingPathComponent(String(int))
    }

    func addingPathComponent(_ string: String?) -> URLComponents {
        string.map(addingPathComponent(_:)) ?? self
    }
    
    func addingPathComponent(_ int: Int?) -> URLComponents {
        int.map(addingPathComponent(_:)) ?? self
    }
    
    func addingQueryItem(_ string: String) -> URLComponents {
        var out = self
        var queryItems = out.queryItems ?? []
        queryItems.append(URLQueryItem(name: string, value: nil))
        out.queryItems = queryItems
        return out
    }

}
