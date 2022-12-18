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
    func open(url: URL)
    
    var isFavorite: Bool { get set }
}


struct PictureView<ViewModel: PictureViewModel>: View {
    
    
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
                    if let (title, body) = info[key] {
                        GridRow {
                            Text(title + ":")
                                .bold()
                            Text(body)
                                .textSelection(.enabled)
                            if let url = URL(string: body) {
                                Button {
                                    viewModel.open(url: url)
                                } label: {
                                    Image(systemName: "arrowshape.turn.up.right")
                                        .font(.callout)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
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

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    
                    author
                        .padding(.bottom)

                        size
                        .padding(.bottom)
                        
                        sourceExamples
                }
                Spacer()
                
                Toggle(isOn: $viewModel.isFavorite) {
                    Text("Favorite")
                }
                .toggleStyle(ImagesToggleStyle(offImageName: "star", onImageName: "star.fill"))
                .labelsHidden()
            }
            .padding()

            Spacer()
        }
    }
}

#if DEBUG

final class ExamplePictureViewModel: PictureViewModel {
    
    var pictureID: Int { 0 }
    
    var isFavorite: Bool = false
    
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
    
    func open(url: URL) {}
    
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(viewModel: ExamplePictureViewModel())
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
#endif

struct ImagesToggleStyle: ToggleStyle {
    
    let offImageName: String
    let onImageName: String
    
    func makeBody(configuration: Configuration) -> some View {
            Image(systemName: configuration.isOn ? onImageName : offImageName)
                .resizable()
                .foregroundColor(configuration.isOn ? Color.yellow : Color(nsColor: .labelColor))
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
    }
}
