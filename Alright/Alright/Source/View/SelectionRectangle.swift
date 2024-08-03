//
//  SelectionRectangle.swift
//  Alright
//
//  Created by 윤동주 on 8/2/24.
//

import SwiftUI

/// 상황 선택 버튼
struct SelectionRectangle: View {
    
    var selected: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(selected 
                      ? AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [.sgmGray4, .sgmGray2]),
                                                              startPoint: .topTrailing,
                                                              endPoint: .bottomLeading))
                      : AnyShapeStyle(.sgmGray2))
                .frame(maxWidth: .infinity, maxHeight: 160)
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(
                            selected 
                            ? AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [.sgmBlue2, .sgmBlue1]),
                                                                    startPoint: .bottomLeading,
                                                                    endPoint: .topTrailing))
                            : AnyShapeStyle(Color.white),
                            lineWidth: 1
                        )
                )
        }
    }
}

#Preview {
    SelectionRectangle(selected: true)
}
