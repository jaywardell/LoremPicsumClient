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

    var sourceWidth: Int { get }
    var sourceHeight: Int { get }

    var grayscale: Bool { get set }
    var blur: Int? { get set }
    var filetype: UTType? { get set }
}

struct PictureEditor<ViewModel: PictureEditorViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var newWidth: Int
    @State private var newHeight: Int

    @State private var newShouldBlur: Bool
    @State private var newBlurRadius: Int

    @State private var newFileType: String
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.newWidth = viewModel.width
        self.newHeight = viewModel.height
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
                        TextField("width", value: $newWidth, format: .ranged(1...Int.max, defaultValue: newWidth))
                            .frame(width: 100)
                        Stepper("", value: $newWidth)
                    }
                }
                .onChange(of: newWidth) { newValue in
                    viewModel.width = newValue
                }
                .onChange(of: viewModel.width) { newValue in
                    newWidth = newValue
                }
                
                GridRow {
                    HStack {
                        Spacer()
                        Text("height: ")
                    }
                    HStack {
                        TextField("height", value: $newHeight, format: .ranged(1...Int.max, defaultValue: newHeight))
                            .frame(width: 100)
                        Stepper("", value: $newHeight)
                    }
                }
                .onChange(of: newHeight) { newValue in
                    viewModel.height = newValue
                }
                .onChange(of: viewModel.height) { newValue in
                    newHeight = newValue
                }

                GridRow {
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])

                    HStack {
                        Button(action: increaseImageSize) {
                            Image(systemName: "plus.circle")
                        }
                        .buttonStyle(.borderless)
                        .help("Increase size proportionally")

                        Button(action: decreaseImageSize) {
                            Image(systemName: "minus.circle")
                        }
                        .buttonStyle(.borderless)
                        .help("Decrease size proportionally")
                    }
                }
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)

                GridRow {
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    Toggle("grayscale", isOn: $viewModel.grayscale)
                        .help("switch picture to grayscale")
                }
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)

                GridRow {
                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    Toggle("blur", isOn: $newShouldBlur)
                        .help("blur picture")
                }
                GridRow {
                    Group {
                        Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        HStack {
                            Text("radius: ")
                            Text(viewModel.blur.map(String.init) ?? "")
                            Stepper("", value: $newBlurRadius)
                                .onChange(of: newBlurRadius) { newValue in
                                    viewModel.blur = min(10, max(1, newValue))
                                    newBlurRadius = viewModel.blur ?? 0
                                }
                                .help("increase or decrease blur")
                        }

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
                    .help("choose what file type is returned")
                }
            }
        }
        .padding()
    }
    
    private var scaling: CGFloat { 1.1 }
    private func decreaseImageSize() {
        newWidth = Int(Double(newWidth) * 1/scaling)
        newHeight = Int(Double(newHeight) * 1/scaling)
    }

    private func increaseImageSize() {
        newWidth = min(Int(Double(newWidth) * scaling), viewModel.sourceWidth)
        newHeight = min(Int(Double(newHeight) * scaling), viewModel.sourceHeight)
    }
}

#if DEBUG

final class ExamplePictureEditorViewModel: PictureEditorViewModel {
    @Published var width: Int = 768
    @Published var height: Int = 1024
    @Published var grayscale: Bool = false
    @Published var blur: Int?
    @Published var filetype: UTType?
    var sourceWidth: Int = 768
    var sourceHeight: Int = 1024
}
let example = ExamplePictureEditorViewModel()

//let example = PictureEditorViewModel(width: 1024, height: 768, grayscale: false)

struct PictureEditor_Previews: PreviewProvider {
    static var previews: some View {
        PictureEditor(viewModel: example)
            .frame(width: 400)
            .previewLayout(.sizeThatFits)
    }
}
#endif
