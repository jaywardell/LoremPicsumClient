//
//  PictureView.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

protocol PictureViewModel: ObservableObject {
    var pictureID: Int { get }
    func pictureURL(size: CGSize) -> URL
    var author: String { get }
    var pictureSize: CGSize { get }
}

struct PictureView<ViewModel: PictureViewModel>: View {
    
    let pictureID: Int
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            LoremPicsumImage(url: viewModel.pictureURL(size: CGSize(width: 512, height: 512)))
            
            Text("Author: ").bold() +
            Text(viewModel.author)
            
            Text("original size").bold()
            Text("width: " + "\(Int(viewModel.pictureSize.width))")
            Text("height: " + "\(Int(viewModel.pictureSize.height))")
        }
    }
}

#if DEBUG

fileprivate final class ExampleViewModel: PictureViewModel {
    
    var pictureID: Int { 127 }
    
    func pictureURL(size: CGSize) -> URL {
        LoremPicsum.picture(id: pictureID, width: Int(size.width)).url
    }
    
    var author: String {
        "Someone"
    }
    
    var pictureSize: CGSize {
        CGSize(width: 1024, height: 768)
    }
    
    
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(pictureID: 127, viewModel: ExampleViewModel())
    }
}
#endif
