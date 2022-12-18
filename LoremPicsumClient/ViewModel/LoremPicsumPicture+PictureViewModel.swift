//
//  LoremPicsumPicture+PictureViewModel.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation
import AppKit
import UniformTypeIdentifiers

extension LoremPicsumPicture: PictureViewModel {
    func pictureURL(size: CGSize) -> URL? {
        guard !editing else { return nil }
        var endpoint = LoremPicsum.picture(id: pictureID, width: Int(size.width), height: Int(size.height))
        if grayscale {
            endpoint = endpoint.grayscale()
        }
        if let blur = blur {
            endpoint = endpoint.blur(radius: blur)
        }
        
        if filetype == .jpeg {
            endpoint = endpoint.jpg()
        }
        else if filetype == .webP {
            endpoint = endpoint.webp()
        }
        
        return endpoint.url
    }
    
    var pictureSize: CGSize {
        CGSize(width: Int(originalWidth), height: Int(originalHeight))
    }
    
    var displaySize: CGSize {
        CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func textInfo(size: CGSize) -> [Int: (String, String)]? {
        guard !editing else { return nil }

        var out = [Int: (String, String)]()
        
        if let url = pictureURL(size: size) {
            let urlString = url.absoluteString
            out[0] = ("url", urlString)
            out[1] = ("html", "<img src=\"\(urlString)\" />")
        }
        
        if let url = sourceURL {
            out[2] = ("source", url.absoluteString)
        }
        
        return out
    }
    
    func open(url: URL) {
        NSWorkspace.shared.open(url)
    }
}
