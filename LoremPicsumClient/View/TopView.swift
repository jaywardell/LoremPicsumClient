//
//  MasterDetail.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

protocol TopViewModel: ObservableObject, PictureViewModel, PictureEditorViewModel {}

struct TopView<ListDataSource: PictureListDataSource, ViewModel: TopViewModel>: View {
    
    @ObservedObject var list: ListDataSource
    
    @State private var selectedPictureID: Int? = nil

    let viewModelForPictureWithID: (Int) -> ViewModel?
    
    var body: some View {
        NavigationSplitView {
            
            PictureList(dataSource: list, selectedID: $selectedPictureID)
        }
    detail: {
        if let selectedPictureID = selectedPictureID {
            let viewModel = viewModelForPictureWithID(selectedPictureID)!
            HStack {
                ScrollView([.vertical, .horizontal]) {
                    PictureView(pictureID: selectedPictureID, viewModel: viewModel)
                }
                Divider()
                VStack {
                    PictureEditor(viewModel: viewModel)
                        .padding()
                    Spacer()
                }
                .frame(width: 240)
            }
        }
        else {
            EmptyView()
        }
    }
    }
}

//struct MasterDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView(list: ExampleDataSource(), viewModelForPictureWithID: { _ in ExamplePictureViewModel() })
//    }
//}
