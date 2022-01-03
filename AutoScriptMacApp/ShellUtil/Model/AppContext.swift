//
//  AppContext.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/1.
//

import Foundation
import SwiftShell

struct AppContextConfig {
    let vars: [String] = ["TERM_PROGRAM", "SHELL", "TERM", "TMPDIR", "Apple_PubSub_Socket_Render", "TERM_PROGRAM_VERSION", "TERM_SESSION_ID", "USER", "SSH_AUTH_SOCK", "__CF_USER_TEXT_ENCODING", "XPC_FLAGS", "XPC_SERVICE_NAME", "SHLVL", "HOME", "LOGNAME", "LC_CTYPE", "_"]
    var path = "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:$HOME/bin:/usr/local/bin"
}

class ShellContextManager {
    var contextConfig: AppContextConfig
    var currentContext: CustomContext = CustomContext()
    
    init(contextConfig: AppContextConfig) {
        self.contextConfig = contextConfig
        currentContext.setupConfig(contextConfig: contextConfig)
    }
}

extension CustomContext {
    mutating func setupConfig(contextConfig: AppContextConfig) {
        env = env.filterToDictionary(keys: contextConfig.vars)
        env["PATH"] = contextConfig.path
    }
}

extension Dictionary where Key:Hashable {
    public func filterToDictionary <C: Collection> (keys: C) -> [Key:Value]
    where C.Iterator.Element == Key {
        var result = [Key:Value](minimumCapacity: keys.count)
        for key in keys { result[key] = self[key] }
        return result
    }
}
