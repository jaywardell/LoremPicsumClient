//
//  LoremPicsumClientApp.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

@main
struct LoremPicsumClientApp: App {
    
    @State private var selectedPictureID: Int?
    
    @StateObject private var list = LoremPicsumList(favorites: Favorites())
    
    var body: some Scene {
        WindowGroup {
            TopView(list: list, viewModelForPictureWithID: {
                list.picture(for: $0)
            })
        }
    }
}
