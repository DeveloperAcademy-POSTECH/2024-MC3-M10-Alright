//
//  ThirdOnboardingPageView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct ThirdOnboardingPageView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Image("OnboardingImage3")
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                }
            
                VStack(spacing: 30) {
                    HStack {
                        Text("실시간 피드백")
                            .font(.Pretendard.SemiBold.size40)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading, 20)
                            .padding(.top, 30)
                        Spacer()
                    }
                    HStack {
                        Text("애니메이션, 색상 등 시각적 피드백을 통해\n목소리 크기를 한 눈에 확인해요!")
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
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ThirdOnboardingPageView()
}
