//
//  MasterDetail.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

struct TopView<ListDataSource: PictureListDataSource>: View {
    
    @ObservedObject var list: ListDataSource

    @State private var selectedPictureID: Int? = nil
    
    var body: some View {
        NavigationSplitView {
            
            PictureList(dataSource: list, selectedID: $selectedPictureID)
        }
    detail: {
        if let selectedPictureID = selectedPictureID {
            PictureView(pictureID: selectedPictureID, viewModel: ExamplePictureViewModel())
        }
        else {
            EmptyView()
        }
    }
    }
}

struct MasterDetail_Previews: PreviewProvider {
    static var previews: some View {
        TopView(list: ExampleDataSource())
    }
}
