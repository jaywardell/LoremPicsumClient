//
//  PictureList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

protocol PictureListDataSource: ObservableObject {
    var pictures: [Int] { get }
    
    func pictureURL(for pictureID: Int, size: CGSize) -> URL
    func pictureSize(for pictureID: Int) -> CGSize
    func loadMoreIfPossible()
}

struct PictureList<DataSource: PictureListDataSource>: View {
    
    @ObservedObject var dataSource: DataSource
        
    private func pictureSize(for pictureID: Int, in viewSize: CGSize) -> CGSize {
        let pictureSize = dataSource.pictureSize(for: pictureID)
        let scalar = viewSize.width / pictureSize.width
        
        return CGSize(width: viewSize.width, height: pictureSize.height * scalar)
    }
    
    var body: some View {
        GeometryReader { geometry in
            List(dataSource.pictures, id: \.self) { id in
                let pictureSize = pictureSize(for: id, in: geometry.size)
                VStack(alignment: .leading) {
                    Text(String(id))
                    let pictureURL = dataSource.pictureURL(for: id, size: pictureSize)
                    LoremPicsumImage(url: pictureURL)
                        .frame(width: pictureSize.width, height: pictureSize.height)
                }
            }
        }
    }
}

#if DEBUG

final class ExampleDataSource: PictureListDataSource {
    var pictures: [Int] { Array(0...20) }
    
    func pictureURL(for int: Int, size: CGSize) -> URL {
        LoremPicsum.randomPicture(width: Int(size.width), height: Int(size.height)).url
    }
    
    func pictureSize(for pictureID: Int) -> CGSize {
        CGSize(width: 1024, height: 768)
    }
    
    func loadMoreIfPossible() {}
}

struct PictureList_Previews: PreviewProvider {
    static var previews: some View {
        PictureList(dataSource: ExampleDataSource())
    }
}
#endif
