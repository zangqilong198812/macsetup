//
//  HomeView.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/2.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                Label("About", systemImage: "info.circle")
                Label("Settings", systemImage: "gear")
                NavigationLink("Edit") {
                    EditFlowView()
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("AutoScript")
        .onAppear {
            runShell()
        }
    }
    
    func runShell() {
        ShellManager.shared.run(bash: "xcodebuild -showsdks -json")
        ShellManager.shared.run(bash: "which xcodebuild")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
