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
    
    enum Filter: String, CaseIterable, Hashable { case all, favorites }
    @State private var filter: Filter = .all

    private func picker() -> some View {
        Picker("List", selection: $filter) {
            ForEach(Filter.allCases, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: filter) { newValue in
            print(newValue)
        }
        
    }

    var body: some View {
        NavigationSplitView {
            
            PictureList(dataSource: list, selectedID: $selectedPictureID)
                .toolbar(content: picker)
        }
    detail: {
        if let selectedPictureID = selectedPictureID,
           let viewModel = viewModelForPictureWithID(selectedPictureID) {
            HStack {
                PictureView(viewModel: viewModel)
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
