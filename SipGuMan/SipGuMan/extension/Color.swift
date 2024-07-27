//
//  Color.swift
//  SipGuMan
//
//  Created by 이상도 on 7/28/24.
//

import SwiftUI

extension Color {
    
    static let basicBackgroundColor = Color("basicBackgroundColor") // 기본 background 색상
    
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
