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
    func textInfo(size: CGSize) -> [Int: (String, String)]?
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

    @ViewBuilder private var size: some View {
        HStack {
            Text("Original Size:").bold()
            Text("width: ").bold() + Text("\(Int(viewModel.pictureSize.width))")
            Text("height: ").bold() + Text("\(Int(viewModel.pictureSize.height))")
        }
    }

    @ViewBuilder private var author: some View {
        Group {
            Text("Author: ").bold() +
            Text(viewModel.author)
        }
    }

    @ViewBuilder private var sourceExamples: some View {
        Grid(alignment: .leading) {
            if let info = viewModel.textInfo(size: viewModel.displaySize) {
                ForEach(info.keys.sorted(), id: \.self) { key in
                    GridRow {
                        Text(info[key]!.0)
                            .bold()
                        Text(info[key]!.1)
                            .textSelection(.enabled)
                    }
                }
            }
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
                        .padding()

                }
                Spacer()
            }

            Divider()

            HStack {
                VStack(alignment: .leading) {
                    
                    author
                        .padding(.bottom)

                        size
                        .padding(.bottom)
                        
                        sourceExamples
                }
                Spacer()
            }
            .padding()

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
    
    func textInfo(size: CGSize) -> [Int: (String, String)]? {
        nil
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(pictureID: 127, viewModel: ExamplePictureViewModel())
    }
}
#endif
