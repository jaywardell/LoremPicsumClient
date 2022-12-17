//
//  ContentView.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LoremPicsumImage(url: URL(string: "https://picsum.photos/id/237/200/300")!)        }
        .frame(width: 200, height: 300)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
