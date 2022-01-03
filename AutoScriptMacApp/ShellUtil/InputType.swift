//
//  ShellInput.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation

protocol CommandInputType {
    associatedtype V: Hashable
    var name: String { get }
    var value: V { get }
}

struct BaseInputType: CommandInputType, Codable {
    typealias V = String
    
    var name: String
    var value: String
}
