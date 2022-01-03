//
//  EditFlowView.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/2.
//

import Foundation
import SwiftUI

struct EditFlowView: View {
    @State var selectPath: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("path")
                TextField("path", text: $selectPath)
                    .frame(maxWidth: 100)
                Button {
                    selectPath = NSOpenPanel.select(fileTypes: ["xcodeproj"])?.path ?? ""
                } label: {
                    Image(symbol: .folder)
                }
                .niceButton()
                .tint(Color.red)
            }
        }
    }
}

struct EditFlowView_Preview: PreviewProvider {
    static var previews: some View {
        EditFlowView()
    }
}
