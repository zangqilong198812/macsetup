//
//  Flow.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation

struct Flow: Codable, Identifiable {
    var id: String = UUID().uuidString
   // var inputs: [InputType]
    var outputs: [OutputType]
}
