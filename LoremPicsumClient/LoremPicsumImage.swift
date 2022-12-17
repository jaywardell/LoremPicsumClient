//
//  LoremPicsumImage.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

struct LoremPicsumImage: View {
    
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
    }
}

struct LoremPicsumImage_Previews: PreviewProvider {
    static var previews: some View {
        LoremPicsumImage(url: URL(string: "https://picsum.photos/100/100")!)
            .frame(width: 100, height: 100)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
