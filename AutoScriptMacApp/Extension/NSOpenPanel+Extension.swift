//
//  NSOpenPanel+Extension.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation
import AppKit

extension NSOpenPanel {
    static func select(fileTypes: [String]) -> URL? {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = fileTypes
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        let response = openPanel.runModal()
        if response == .OK {
            return openPanel.url
        }
        return nil
    }
}
