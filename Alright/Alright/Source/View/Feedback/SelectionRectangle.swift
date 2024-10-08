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
    var isAnySelected: Bool // 상황cell Color 조절해주는 Selected 여부 변수
    
    var isSelected: Bool {
        self.situation == currentSituation
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(isSelected
                          ? AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [.sgmGray4, .sgmGray2]),
                                                         startPoint: .topTrailing,
                                                         endPoint: .bottomLeading))
                          : isAnySelected ? AnyShapeStyle(.sgmGray1) : AnyShapeStyle(.sgmGray2))
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
                    .overlay {
                        VStack(spacing: 6) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(LocalizedStringResource(stringLiteral: situation.title))
                                        .font(.Pretendard.SemiBold.size22)
                                        .foregroundColor(.white)
                                    Text(LocalizedStringResource(stringLiteral: situation.subtitle ?? ""))
                                        .font(.Pretendard.Regular.size12)
                                        .foregroundColor(.sgmGrayA)
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                situation.image
                                    .resizable()
                                    .frame(width: 64, height: 64)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 24)
                    }
            }
            .frame(width: geometry.size.width, height: geometry.size.width) // 1:1 비율 유지
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    SelectionRectangle(situation: .quietTalking,
                       currentSituation: .quietTalking,
                       isAnySelected: true)
}
