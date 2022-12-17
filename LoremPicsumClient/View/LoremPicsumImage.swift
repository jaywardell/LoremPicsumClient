//
//  LoremPicsumImage.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

struct LoremPicsumImage: View {
    
    let url: URL
    
    private var progress: some View {
        ProgressView()
    }
    
    private var image: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            progress
        }
    }
    
    var body: some View {
        // while developing,
        // we don't want to spam the service
        // with every edit
        // so just show a progress view
        // in the preview
        if ProcessInfo.isInXCodePreviewCanvass {
            progress
        }
        else {
            image
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
