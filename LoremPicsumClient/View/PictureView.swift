//
//  PictureView.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

protocol PictureViewModel: ObservableObject {
    var pictureID: Int { get }
    func pictureURL(size: CGSize) -> URL?
    var author: String { get }
    var pictureSize: CGSize { get }
    var displaySize: CGSize { get }
}


struct PictureView<ViewModel: PictureViewModel>: View {
    
    let pictureID: Int
    
    @ObservedObject var viewModel: ViewModel
    
    @ViewBuilder private var image: some View {
        let displaySize = viewModel.displaySize
        if let url = viewModel.pictureURL(size: displaySize) {
            LoremPicsumImage(url: url)
        }
        else {
            ProgressView()
        }
    }

    @ViewBuilder private var info: some View {
        Group {
            Text("Author: ").bold() +
            Text(viewModel.author)
        }.padding(.bottom)
        
        Group {
            Text("Original Size").bold()
            Text("width: ").bold() + Text("\(Int(viewModel.pictureSize.width))")
            Text("height: ").bold() + Text("\(Int(viewModel.pictureSize.height))")
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView([.vertical, .horizontal]) {
  
                    image
                        .frame(width: viewModel.displaySize.width, height: viewModel.displaySize.height)
                        .background(Rectangle().stroke(lineWidth: 2).foregroundColor(Color(nsColor: .labelColor)))
                        .shadow(radius: 5)

                }
                Spacer()
            }

            info
            
            Spacer()
        }
    }
}

#if DEBUG

final class ExamplePictureViewModel: PictureViewModel {
    
    var pictureID: Int { 0 }
    
    func pictureURL(size: CGSize) -> URL? {
        LoremPicsum.picture(id: pictureID, width: Int(size.width)).url
    }
    
    var author: String {
        "Someone"
    }
    
    var pictureSize: CGSize {
        CGSize(width: 1024, height: 768)
    }
    
    var displaySize: CGSize {
        CGSize(width: 1024, height: 768)
    }
    
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(pictureID: 127, viewModel: ExamplePictureViewModel())
    }
}
#endif
