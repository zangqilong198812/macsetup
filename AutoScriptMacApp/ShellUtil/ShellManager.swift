//
//  ShellManager.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation
import SwiftShell
import SwiftyBeaver

final class ShellManager {
    private var context = CustomContext()
    static let shared = ShellManager()
    
    init() {
        context.setupConfig(contextConfig: AppContextConfig())
    }
    
    func run(command: String, argus: [String]) {
        let command = context.runAsync(command, argus)
        command.onCompletion { asyncCommand in
            //print(asyncCommand.stdout.read())
        }
        command.stdout.onStringOutput { output in
            print(output)
        }
        command.stderror.onStringOutput { error in
            print(error)
        }
        print(command.terminationReason())
        do {
            try command.finish()
            
        } catch let error {
            print("\(error.localizedDescription), \(error)")
        }
    }
    
    func run(bash: String) {
        log.debug("\(bash) run")
        let command = context.runAsync(bash: bash)
        command.onCompletion { asyncCommand in
            //print(asyncCommand.stdout.read())
        }
        command.stdout.onStringOutput { output in
            log.verbose(output)
        }
        command.stderror.onStringOutput { error in
            log.error(error)
        }
        log.debug("\(command.exitcode())")
        do {
            try command.finish()
            log.debug("command finished")
        } catch let error {
            print("\(error.localizedDescription), \(error)")
        }
    }
}
