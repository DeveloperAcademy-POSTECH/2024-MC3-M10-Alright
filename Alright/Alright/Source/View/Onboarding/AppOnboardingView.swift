//
//  AppOnboardingView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct AppOnboardingView: View {
    
    @Environment(\.dismiss) private var dismiss // Onboarding dismiss
    @AppStorage("isFirstOnboarding") private var isFirstOnboarding: Bool?
    
    @State private var selectedPage = 0
    
    private let onboardingPages: [Onboarding] = [.first, .second, .third, .fourth]
    
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
                    .opacity(selectedPage == onboardingPages.count - 1 ? 0 : 1)
                }
                
                TabView(selection: $selectedPage) {
                    ForEach(Array(Onboarding.allCases.enumerated()), id: \.element) { index, onboarding in
                        OnboardingPageView(
                            nowOnboard: onboardingPages[index]
                        )
                        .id(index)
                        .tag(index)
                    }
                }
                .ignoresSafeArea()
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
            // Indicator
            VStack {
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(onboardingPages.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(index == selectedPage ? .sgmBlue1 : .sgmBlue1.opacity(0.3))
                            .opacity(selectedPage == onboardingPages.count - 1 ? 0 : 1)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
