//
//  PictureEditor.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import SwiftUI
import UniformTypeIdentifiers

protocol PictureEditorViewModel: ObservableObject {
    var width: Int { get set }
    var height: Int { get set }
    var grayscale: Bool { get set }
    var blur: Int? { get set }
    var filetype: UTType? { get set }
}

//final class PictureEditorViewModel: ObservableObject {
//    var width: Int
//    var height: Int
//    var grayscale: Bool
//    var blur: Int?
//    var filetype: UTType?
//
//    init(width: Int, height: Int, grayscale: Bool, blur: Int? = nil, filetype: UTType? = nil) {
//        self.width = width
//        self.height = height
//        self.grayscale = grayscale
//        self.blur = blur
//        self.filetype = filetype
//    }
//}

struct PictureEditor<ViewModel: PictureEditorViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var newWidth: String
    @State private var newHeight: String

    @State private var newShouldBlur: Bool
    @State private var newBlurRadius: Int

    @State private var newFileType: String
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.newWidth = String(viewModel.width)
        self.newHeight = String(viewModel.height)
        self.newShouldBlur = viewModel.blur == nil ? false : true
        self.newBlurRadius = viewModel.blur ?? 0
        
        switch viewModel.filetype {
        case UTType.webP: self.newFileType = "webP"
        case UTType.jpeg: self.newFileType = "jpeg"
        default: self.newFileType = ""
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Grid(alignment: .leading) {
                GridRow {
                    HStack {
                        Spacer()
                        Text("width: ")
                    }
                    HStack {
                        TextField("width", text: $newWidth)
                            .frame(width: 100)
                            .onChange(of: newWidth) { newValue in
                                let newValue = Int(newValue) ?? nil
                                if let newValue = newValue {
                                    viewModel.width = newValue
                                }
                                newWidth = String(viewModel.width)
                            }
                        Stepper("", value: $viewModel.width)
                            .onChange(of: viewModel.width) { newValue in
                                newWidth = String(newValue)
                            }
                    }
                }
                
                
                GridRow {
                    HStack {
                        Spacer()
                        Text("height: ")
                    }
                    HStack {
                        TextField("height", text: $newHeight)
                            .frame(width: 100)
                            .onChange(of: newHeight) { newValue in
                                let newValue = Int(newValue) ?? nil
                                if let newValue = newValue {
                                    viewModel.height = newValue
                                }
                                newHeight = String(viewModel.height)
                            }
                        Stepper("", value: $viewModel.height)
                            .onChange(of: viewModel.height) { newValue in
                                newHeight = String(newValue)
                            }
                    }
                }
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)

                GridRow {
//                    HStack {}
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    Toggle("grayscale", isOn: $viewModel.grayscale)
//                    HStack {}
                }
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)

                GridRow {
//                    HStack {}
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    Toggle("blur", isOn: $newShouldBlur)
                }
                GridRow {
//                    HStack {}
                    Group {
                        Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        HStack {
                            Text("radius: ")
                            Text(viewModel.blur.map(String.init) ?? "")
                            Stepper("", value: $newBlurRadius)
                                .onChange(of: newBlurRadius) { newValue in
                                    viewModel.blur = min(10, max(1, newValue))
                                }
                        }

//                        TextField("blur radius", text: $newBlurRadius)
//                            .frame(width: 100)
//                            .onChange(of: newBlurRadius) { newValue in
//                                guard let newValue = Int(newValue) else { return }
//                                viewModel.blur = newValue > 0 ? min(10, max(1, newValue)) : nil
//                                newBlurRadius = viewModel.blur.map(String.init) ?? ""
//                            }
                    }
                    .opacity(viewModel.blur == nil ? 0 : 1)
                }
                .onChange(of: newShouldBlur) { newValue in
                    viewModel.blur = newValue ? 1 : nil
                }
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)

                GridRow(alignment: .top) {
                    HStack {
                        Spacer()
                        Text("file type")
                    }

                    Picker(selection: $newFileType, label: EmptyView()) {
                        Text("none").tag("")
                        Text("jpeg").tag("jpeg")
                        Text("webP").tag("webP")
                    }
                    .onChange(of: newFileType) { newValue in
                        switch newValue {
                        case "jpeg": viewModel.filetype = .jpeg
                        case "webP": viewModel.filetype = .webP
                        default: viewModel.filetype = nil
                        }
                    }
                    .pickerStyle(RadioGroupPickerStyle())
                }
            }
        }
        .padding()
    }
}

#if DEBUG

final class ExamplePictureEditorViewModel: PictureEditorViewModel {
    @Published var width: Int = 768
    @Published var height: Int = 1024
    @Published var grayscale: Bool = false
    @Published var blur: Int?
    @Published var filetype: UTType?
}
let example = ExamplePictureEditorViewModel()

//let example = PictureEditorViewModel(width: 1024, height: 768, grayscale: false)

//struct PictureEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        PictureEditor(viewModel: example)
//            .frame(width: 400)
//            .previewLayout(.sizeThatFits)
//    }
//}
#endif
