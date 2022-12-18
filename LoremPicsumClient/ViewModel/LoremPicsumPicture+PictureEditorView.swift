//
//  LoremPicsumPicture+PictureEditorView.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension LoremPicsumPicture: PictureEditorViewModel {
    var sourceWidth: Int { originalWidth }
    var sourceHeight: Int { originalHeight }    
}
