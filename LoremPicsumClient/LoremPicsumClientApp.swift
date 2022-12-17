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
    
    @StateObject private var list = LoremPicsumList()
    
    var body: some Scene {
        WindowGroup {
            TopView(list: list)
        }
    }
}
