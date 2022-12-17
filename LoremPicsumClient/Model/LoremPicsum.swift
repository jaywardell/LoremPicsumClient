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
    
    // see https://picsum.photos for documenation on the API for LoremPicsum

    private static let host = "picsum.photos"
    private static var base: URLComponents {
        var out = URLComponents()
        out.host = host
        out.scheme = "https"
        return out
    }
    
    static func randomPicture(width: Int, height: Int) -> LoremPicsum {
        base
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map { LoremPicsum(url: $0, width: CGFloat(width), height: CGFloat(height)) }!
    }
    
    static func randomPicture(square width: Int) -> LoremPicsum {
        base
            .addingPathComponent(width)
            .url
            .map { LoremPicsum(url: $0, width: CGFloat(width), height: CGFloat(width)) }!
    }

    static func picture(id: Int, width: Int, height: Int) -> LoremPicsum {
        base
            .addingPathComponent("id")
            .addingPathComponent(id)
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map { LoremPicsum(url: $0, width: CGFloat(width), height: CGFloat(height)) }!
    }
    
    static func picture(id: Int, square width: Int) -> LoremPicsum {
        base
            .addingPathComponent("id")
            .addingPathComponent(id)
            .addingPathComponent(width)
            .url
            .map { LoremPicsum(url: $0, width: CGFloat(width), height: CGFloat(width)) }!
    }

}

// MARK: -

extension URLComponents {
    func with(path: String) -> URLComponents {
        var out = self
        out.path = path
        return out
    }
    
    func addingPathComponent(_ string: String) -> URLComponents {
        var out = self
        out.path += "/" + string
        return out
    }
    
    func addingPathComponent(_ int: Int) -> URLComponents {
        addingPathComponent(String(int))
    }
 }
