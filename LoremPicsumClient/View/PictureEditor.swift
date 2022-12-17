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

struct PictureEditor<ViewModel: PictureEditorViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var newWidth: String = ""
    @State private var newHeight: String = ""

    @State private var newShouldBlur = false
    @State private var newBlurRadius: String = ""

    @State private var newFileType: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("width: ")
                TextField("width", text: $newWidth)
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
            
            
            HStack {
                Text("height: ")
                TextField("height", text: $newHeight)
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
            
            Toggle("grayscale", isOn: $viewModel.grayscale)

            Toggle("blur", isOn: $newShouldBlur)
            HStack {
                Text("blue radius: ")
                TextField("blur radius", text: $newBlurRadius)
                    .onChange(of: newBlurRadius) { newValue in
                        guard let newValue = Int(newValue) else { return }
                        viewModel.blur = newValue > 0 ? newValue : nil
                    }
            }
            .onChange(of: newShouldBlur) { newValue in
                viewModel.blur = newValue ? 1 : nil
            }

            Picker(selection: $newFileType, label: Text("file type:")) {
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

struct PictureEditor_Previews: PreviewProvider {
    static var previews: some View {
        PictureEditor(viewModel: ExamplePictureEditorViewModel())
            .frame(width: 300)
            .previewLayout(.sizeThatFits)
    }
}
#endif
