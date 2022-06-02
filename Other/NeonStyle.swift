//
//  NeonStyle.swift
//  Calculator
//
//  Created by William Hinson on 3/14/22.
//

import Foundation
import SwiftUI

struct NeonStyle: ViewModifier {
    let color: Color
    @Binding var blurRadius: CGFloat
    
    func body(content: Content) -> some View {
        return ZStack {
            content.foregroundColor(color)
            content.blur(radius: blurRadius)
        }
        .padding(10)
//        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(color, lineWidth: 4))
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(color, lineWidth: 4).brightness(0.1).blur(radius: blurRadius))
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(color, lineWidth: 4).brightness(0.1).blur(radius: blurRadius).opacity(0.2))
        .compositingGroup()
    }
}
