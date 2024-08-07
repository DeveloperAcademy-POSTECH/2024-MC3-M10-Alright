//
//  SelectionRectangle.swift
//  Alright
//
//  Created by 윤동주 on 8/2/24.
//

import SwiftUI

/// 상황 선택 버튼
struct SelectionRectangle: View {
    
    var situation: Situation
    var currentSituation: Situation?
    
    var isSelected: Bool {
        self.situation == currentSituation
    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(isSelected
                      ? AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [.sgmGray4, .sgmGray2]),
                                                              startPoint: .topTrailing,
                                                              endPoint: .bottomLeading))
                      : AnyShapeStyle(.sgmGray2))
                .frame(maxWidth: .infinity, maxHeight: 160)
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(
                            isSelected
                            ? AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [.sgmBlue2, .sgmBlue1]),
                                                                    startPoint: .bottomLeading,
                                                                    endPoint: .topTrailing))
                            : AnyShapeStyle(Color.white),
                            lineWidth: 1
                        )
                )
            
            VStack {
                HStack {
                    Text(situation.title)
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .semibold))
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text(situation.subtitle ?? "")
                        .foregroundColor(.sgmGrayA)
                        .font(.system(size: 12, weight: .regular))
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Spacer()
                    situation.image
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    SelectionRectangle(situation: .auditorium,
                       currentSituation: .auditorium)
}
