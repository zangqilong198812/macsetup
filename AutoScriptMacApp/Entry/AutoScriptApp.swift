//
//  AutoScriptMacAppApp.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import SwiftUI
import SwiftyBeaver

@main
struct AutoScriptApp: App {
    
    init() {
        log.addDestination(ConsoleDestination())
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

public let log = SwiftyBeaver.self
