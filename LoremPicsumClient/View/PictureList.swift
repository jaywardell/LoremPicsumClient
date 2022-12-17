//
//  PictureList.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

protocol PictureListDataSource: ObservableObject {
    var pictures: [Int] { get }
    
    func pictureURL(for int: Int, size: CGSize) -> URL
    func loadMoreIfPossible()
}

struct PictureList<DataSource: PictureListDataSource>: View {
    
    @ObservedObject var dataSource: DataSource
    
    let pictureWidth: CGFloat
    
    private func pictureSize() -> CGSize {
        CGSize(width: pictureWidth, height: pictureWidth)
    }
    
    var body: some View {
        List(dataSource.pictures, id: \.self) { id in
            VStack(alignment: .leading) {
                Text(String(id))
                let pictureURL = dataSource.pictureURL(for: id, size: pictureSize())
                LoremPicsumImage(url: pictureURL)
                    .frame(width: pictureSize().width, height: pictureSize().height)
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
    
    func loadMoreIfPossible() {}
}

struct PictureList_Previews: PreviewProvider {
    static var previews: some View {
        PictureList(dataSource: ExampleDataSource(), pictureWidth: 200)
    }
}
#endif
