//
//  Button+Extension.swift
//  AutoScriptMacApp
//
//  Created by zang qilong on 2022/1/2.
//

import Foundation
import SwiftUI

struct NiceButtonStyle: ButtonStyle {
    var foregroundColor: Color
    var backgroundColor: Color
    var pressedColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(5)
            .foregroundColor(foregroundColor)
            .background(configuration.isPressed ? pressedColor : backgroundColor)
            .cornerRadius(5)
    }
}

extension View {
    func niceButton(
        foregroundColor: Color = .white,
        backgroundColor: Color = .gray,
        pressedColor: Color = .accentColor
    ) -> some View {
        self.buttonStyle(
            NiceButtonStyle(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                pressedColor: pressedColor
            )
        )
    }
}
