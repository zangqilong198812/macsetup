//
//  ShellScript.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation

struct ShellScript {
    let command: String
    let args: [ShellArgument]
}

struct ShellArgument {
    let flag: String?
    let value: String
    var description: String?
}
