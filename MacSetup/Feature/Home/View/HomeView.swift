//
//  ContentView.swift
//  MacSetup
//
//  Created by zang qilong on 2021/12/13.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack {
            VStack {
                Text("hello")
            }
            VStack {
                List {
                    
                }
            }
        }.frame(minWidth: 500, minHeight: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
