//
//  AppOnboardingView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct AppOnboardingView: View {
    
    @Environment(\.dismiss) private var dismiss // Onboarding dismiss
    @AppStorage("isFirstOnboarding") var isFirstOnboarding = true
    
    private let totalPages = 4
    @State private var selectedPage = 0
    
    private let onboardingPages: [Onboarding] = [
        .first, .second, .third, .fourth
    ]
    
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
                    ForEach(0..<totalPages, id: \.self) { index in
                        OnboardingPageView(
                            nowOnboard: onboardingPages[index],
                            nowPage: selectedPage
                        )
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
