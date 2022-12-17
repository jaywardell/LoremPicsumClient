//
//  LoremPicsum.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

enum LoremPicsum {
    // see https://picsum.photos for documenation on the API for LoremPicsum

    private static let host = "picsum.photos"
    private static var base: URLComponents {
        var out = URLComponents()
        out.host = host
        out.scheme = "https"
        return out
    }
    
    static func randomPicture(width: Int, height: Int) -> URL {
        base
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url!
    }
    
    static func randomPicture(square width: Int) -> URL {
        base
            .addingPathComponent(width)
            .url!
    }

    static func picture(id: Int, width: Int, height: Int) -> URL {
        base
            .addingPathComponent("id")
            .addingPathComponent(id)
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url!
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
