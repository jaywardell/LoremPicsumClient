//
//  MasterDetail.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI

protocol TopViewPictureModel: ObservableObject, PictureViewModel, PictureEditorViewModel {}

struct TopView<ListDataSource: PictureListDataSource, ViewModel: TopViewPictureModel>: View {
    
    @ObservedObject var list: ListDataSource
    
    @State private var selectedPictureID: Int? = nil

    let viewModelForPictureWithID: (Int) -> ViewModel?
    
    @State private var filter: Filter = .all

    let filterChanged: (Filter)->()
    
    private func picker() -> some View {
        Picker("List", selection: $filter) {
            ForEach(Filter.allCases, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: filter) { newValue in
            filterChanged(newValue)
        }
    }

    var body: some View {
        NavigationSplitView {
            
            PictureList(dataSource: list, selectedID: $selectedPictureID)
                .toolbar(content: picker)
                .frame(minWidth: 233)
        }
    detail: {
        if let selectedPictureID = selectedPictureID,
           let viewModel = viewModelForPictureWithID(selectedPictureID) {
            HStack {
                PictureView(viewModel: viewModel)
                    .frame(minWidth: 377)

                Divider()

                VStack {
                    PictureEditor(viewModel: viewModel)
                        .padding()
                    Spacer()
                }
                .frame(width: 233)
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
