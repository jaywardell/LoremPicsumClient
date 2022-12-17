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
    func loadMoreIfPossible(currentID: Int)
}

struct PictureList<DataSource: PictureListDataSource>: View {
    
    @ObservedObject var dataSource: DataSource
        
    @Binding var selectedID: Int?
    
    private func pictureSize(for pictureID: Int, in viewSize: CGSize) -> CGSize {
        let pictureSize = dataSource.pictureSize(for: pictureID)
        let scalar = viewSize.width / pictureSize.width
        
        return CGSize(width: viewSize.width, height: pictureSize.height * scalar)
    }
    
    private var picturePadding: CGFloat { 100 }
    private var minimumPictureWidth: CGFloat { 128 }

    @ViewBuilder private func cell(for pictureID: Int, listSize: CGSize) -> some View {
        let lSize = CGSize(width: listSize.width - picturePadding, height: listSize.height)
        let pictureSize = pictureSize(for: pictureID, in: lSize)
        
        let pictureURL = dataSource.pictureURL(for: pictureID, size: pictureSize)
        HStack {
            Spacer()
            LoremPicsumImage(url: pictureURL)
                .frame(width: pictureSize.width, height: pictureSize.height)
            Spacer()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            List(dataSource.pictures, id: \.self) { id in
                cell(for: id, listSize: geometry.size)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.accentColor)
                            .opacity(id == selectedID ? 1 : 0)
                    }
                    .onTapGesture {
                        selectedID = id
                    }
                    .onAppear {
                      dataSource.loadMoreIfPossible(currentID: id)
                    }
            }
        }
        .frame(minWidth: picturePadding + minimumPictureWidth)

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
    
    func loadMoreIfPossible(currentID: Int) {}
}

struct PictureList_Previews: PreviewProvider {
    static var previews: some View {
        PictureList(dataSource: ExampleDataSource(), selectedID: .constant(nil))
    }
}
#endif
