//
//  FlowCardView.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/3.
//

import SwiftUI

struct FlowCardView: View {
    var body: some View {
        VStack {
            HStack {
                Image(symbol: .bookFill)
                    .foregroundColor(.blue)
                Text("Baloo")
                Spacer()
                Image(symbol: .ellipsis)
            }
            HStack {
                Text("script")
            }
        }
        .frame(maxWidth: 300)
    }
}

struct FlowCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlowCardView()
    }
}
