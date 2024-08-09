//
//  SecondOnboardingPageView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct SecondOnboardingPageView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Image("OnboardingImage2")
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                }
            
                VStack(spacing: 30) {
                    HStack {
                        Text("상황 선택")
                            .font(.Pretendard.SemiBold.size40)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading, 20)
                            .padding(.top, 30)
                        Spacer()
                    }
                    HStack {
                        Text("대화, 발표 등 다양한 상황에 맞추어\n목소리 크기 조절을 도와드려요!")
                            .font(.Pretendard.Medium.size20)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading, 20)
                            .lineSpacing(4)
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 316)
                .background(.sgmBlack)
                
            }
            .ignoresSafeArea(edges: .bottom) // 하단 여백을 무시하여 하단에 붙도록 설정
        }
    }
}

#Preview {
    SecondOnboardingPageView()
}
