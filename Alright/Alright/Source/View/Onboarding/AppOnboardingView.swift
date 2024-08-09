//
//  AppOnboardingView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct AppOnboardingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var isFirstOnboarding: Bool // 앱 Onboarding
    @Binding var isCompletedOnboarding: Bool // 도움말 Onboarding
    
    private let totalPages = 4
    @State private var selectedPage = 0
    
    var body: some View {
        ZStack {
            Color.sgmGray2
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        isFirstOnboarding = false
                        dismiss()
                    } label: {
                        Text("Skip")
                            .font(.Pretendard.Light.size17)
                            .foregroundColor(.sgmGrayA)
                    }
                    .padding(.trailing)
                    .opacity(selectedPage == 3 ? 0 : 1)
                }
                
                TabView(selection: $selectedPage) {
                    OnboardingCommonPageView(
                        title: "Alright",
                        subtitle: "청각장애인의 목소리 크기 조절을\n도와드리는 앱 올라잇이에요." ,
                        imageName: "OnboardingImage1"
                    )
                    .tag(0)
                    
                    OnboardingCommonPageView(
                        title: "상황 선택",
                        subtitle: "대화, 발표 등 다양한 상황에 맞추어\n목소리 크기 조절을 도와드려요!" ,
                        imageName: "OnboardingImage2"
                    )
                    .tag(1)
                    
                    OnboardingCommonPageView(
                        title: "실시간 피드백",
                        subtitle: "애니메이션, 색상 등 시각적 피드백을 통해\n목소리 크기를 한 눈에 확인해요!" ,
                        imageName: "OnboardingImage3"
                    )
                    .tag(2)
                    
                    OnboardingLastPageView(
                        title: "백그라운드",
                        subtitle: "Dynamic Island, Live Activity로\n다른 화면을 보며 모니터링 할 수 있어요!" ,
                        imageName: "OnboardingImage4",
                        isFirstOnboarding: $isFirstOnboarding,
                        isCompletedOnboarding: $isCompletedOnboarding
                    )
                    .tag(3)
                }
                .ignoresSafeArea()
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
            // Indicator
            VStack {
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(index == selectedPage ? .sgmBlue1 : .sgmBlue1.opacity(0.3))
                            .opacity(selectedPage == 3 ? 0 : 1)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
