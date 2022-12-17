//
//  ProcessInfo+XCodePreviews.swift
//  LoremPicsumClient
//
//  Created by Joseph Wardell on 12/17/22.
//

import Foundation

extension ProcessInfo {
    static var isInXCodePreviewCanvass: Bool {
        processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
