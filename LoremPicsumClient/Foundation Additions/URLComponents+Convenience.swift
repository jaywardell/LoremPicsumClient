//
//  URLComponents+Convenience.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

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

    func addingPathExtension(_ string: String) -> URLComponents {
        var out = self
        out.path += "." + string
        return out
    }

    func addingQueryItem(_ string: String, value: String? = nil) -> URLComponents {
        var out = self
        var queryItems = out.queryItems ?? []
        queryItems.append(URLQueryItem(name: string, value: value))
        out.queryItems = queryItems
        return out
    }

    func addingQueryItem(_ string: String, value: Int) -> URLComponents {
        addingQueryItem(string, value: String(value))
    }
    
    func addingQueryItem(_ string: String, value: Int?) -> URLComponents {
        addingQueryItem(string, value: value.map(String.init))
    }


}
