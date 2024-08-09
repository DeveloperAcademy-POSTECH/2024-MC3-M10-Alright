//
//  SecondOnboardingPageView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct FirstOnboardingPageView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Image("OnboardingImage1")
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                }
            
                VStack(spacing: 30) {
                    HStack {
                        Text("Alright")
                            .font(.Pretendard.SemiBold.size40)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading)
                            .padding(.top, 30)
                        Spacer()
                    }
                    HStack {
                        Text("청각장애인의 목소리 크기 조절을\n도와드리는 앱 올라잇이에요.")
                            .font(.Pretendard.Medium.size20)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading)
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
    FirstOnboardingPageView()
}
