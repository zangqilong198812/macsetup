//
//  OutputType.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation

enum OutputType: Codable {
    case file(path: String)
    case text(content: String)
    case json(content: String)
}
