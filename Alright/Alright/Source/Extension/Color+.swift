//
//  Color+.swift
//  SipGuMan
//
//  Created by 윤동주 on 7/26/24.
//

import SwiftUI

extension Color {

    static let basicBackgroundColor = Color("ColorBasicbackground") // 기본 background 색상 #222222
    static let pointColor1 = Color("ColorPoint1") // #ADBAFF
    static let pointColor2 = Color("ColorPoint2") // #3D5CFF
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

