//
//  MasterDetail.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

struct TopView<ListDataSource: PictureListDataSource, PictureVM: PictureViewModel>: View {
    
    @ObservedObject var list: ListDataSource

    @State private var selectedPictureID: Int? = nil
    
    let viewModelForPictureWithID: (Int) -> PictureVM?
    
    var body: some View {
        NavigationSplitView {
            
            PictureList(dataSource: list, selectedID: $selectedPictureID)
        }
    detail: {
        if let selectedPictureID = selectedPictureID {
            PictureView(pictureID: selectedPictureID, viewModel: viewModelForPictureWithID(selectedPictureID)!)
        }
        else {
            EmptyView()
        }
    }
    }
}

struct MasterDetail_Previews: PreviewProvider {
    static var previews: some View {
        TopView(list: ExampleDataSource(), viewModelForPictureWithID: { _ in ExamplePictureViewModel() })
    }
}
