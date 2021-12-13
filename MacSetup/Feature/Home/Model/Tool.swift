//
//  Tool.swift
//  MacSetup
//
//  Created by zang qilong on 2021/12/13.
//

import Foundation

struct Tool: Codable, CustomStringConvertible, ListItem {
    let id: Int
    let name: String
    let icon: String
    let description: String
    
}


struct ToolSection: Codable, ListSection {
    typealias Item = Tool
    let header: String?
    var items: [Tool]
}

