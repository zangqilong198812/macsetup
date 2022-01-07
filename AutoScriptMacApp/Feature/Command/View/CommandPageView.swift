//
//  CommandPageView.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/5.
//

import SwiftUI

struct CommandPageView: View {
    @State var query = ""
    @State var filePath: String?
    var body: some View {
        VStack {
            if let path = commandPath(), let markdown = try? String(contentsOfFile: path) {
                Text(markdown)
            }
        }
    }
    
    func commandPath() -> String? {
        return Bundle.main.path(forResource: "ls", ofType: "md")
    }
}

struct CommandPageView_Previews: PreviewProvider {
    static var previews: some View {
        CommandPageView()
    }
}
