//
//  LoremPicsum.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation
import UniformTypeIdentifiers

struct LoremPicsum {
    
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    let seed: String?
    let id: Int?
    
    let randomID: String?
    
    let isGrayscale: Bool
    let blurRadius: Int
    
    let fileType: UTType?
    
    // see https://picsum.photos for documenation on the API for LoremPicsum
    
    private init(url: URL, width: CGFloat, height: CGFloat, seed: String?, id: Int?, randomID: String?, isGrayscale: Bool, blurRadius: Int, fileType: UTType?) {
        self.url = url
        self.width = width
        self.height = height
        self.seed = seed
        self.id = id
        self.randomID = randomID
        self.isGrayscale = isGrayscale
        self.blurRadius = blurRadius
        self.fileType = fileType
    }
    
    private static let host = "picsum.photos"
    private static var base: URLComponents {
        var out = URLComponents()
        out.host = host
        out.scheme = "https"
        return out
    }
    
    private static var version2: URLComponents {
        base
            .addingPathComponent("v2")
    }
    
    static func list(page: Int, picturesPerPage: Int) -> URL {
        assert(page > 0, "LoremPicsum pages are indexed from 1")
        return version2
            .addingPathComponent("list")
            .addingQueryItem("page", value: page)
            .addingQueryItem("limit", value: picturesPerPage)
            .url!
    }
    
    static func infoForPicture(id: Int) -> URL {
        base
            .addingPathComponent("id")
            .addingPathComponent(id)
            .addingPathComponent("info")
            .url!
    }
    
    static func infoForPicture(seed: String) -> URL {
        base
            .addingPathComponent("seed")
            .addingPathComponent(seed)
            .addingPathComponent("info")
            .url!
    }

    static func randomPicture(width: Int, height: Int? = nil) -> LoremPicsum {
        base
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height ?? width),
                            seed: nil, id: nil,
                            randomID: nil,
                            isGrayscale: false,
                            blurRadius: 0,
                            fileType: nil) }!
    }
    
    static func picture(id: Int, width: Int, height: Int? = nil) -> LoremPicsum {
        base
            .addingPathComponent("id")
            .addingPathComponent(id)
            .addingPathComponent(width)
            .addingPathComponent(height)
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height ?? width),
                            seed: nil,
                            id: id,
                            randomID: nil,
                            isGrayscale: false,
                            blurRadius: 0,
                            fileType: nil) }!
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
                            seed: seed,
                            id: nil,
                            randomID: nil,
                            isGrayscale: false,
                            blurRadius: 0,
                            fileType: nil)
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
                            seed: seed,
                            id: nil,
                            randomID: randomID,
                            isGrayscale: true,
                            blurRadius: 0,
                            fileType: nil)
            }!
    }
    
    func blur(radius: Int? = nil) -> LoremPicsum {
        URLComponents(url: url, resolvingAgainstBaseURL: false)!
            .addingQueryItem("blur", value: radius)
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height),
                            seed: seed,
                            id: nil,
                            randomID: randomID,
                            isGrayscale: isGrayscale,
                            blurRadius: radius ?? 1,
                            fileType: nil)
            }!
    }

    func randomID(_ id: String?) -> LoremPicsum {
        URLComponents(url: url, resolvingAgainstBaseURL: false)!
            .addingQueryItem("random", value: id)
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height),
                            seed: seed,
                            id: nil,
                            randomID: id,
                            isGrayscale: isGrayscale,
                            blurRadius: blurRadius,
                            fileType: nil)
            }!
   }
    
    func jpg() -> LoremPicsum {
        URLComponents(url: url, resolvingAgainstBaseURL: false)!
            .addingPathExtension("jpg")
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height),
                            seed: seed,
                            id: nil,
                            randomID: randomID,
                            isGrayscale: isGrayscale,
                            blurRadius: blurRadius,
                            fileType: .jpeg)
            }!
    }
    
    func webp() -> LoremPicsum {
        URLComponents(url: url, resolvingAgainstBaseURL: false)!
            .addingPathExtension("webp")
            .url
            .map {
                LoremPicsum(url: $0,
                            width: CGFloat(width),
                            height: CGFloat(height),
                            seed: seed,
                            id: nil,
                            randomID: randomID,
                            isGrayscale: isGrayscale,
                            blurRadius: blurRadius,
                            fileType: .webP)
            }!
    }

}


