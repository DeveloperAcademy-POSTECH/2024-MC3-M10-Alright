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
    
    @State private var selectedOnboarding: Onboarding = .first
    
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
                    .opacity(selectedOnboarding == .fourth ? 0 : 1)
                }
                
                TabView(selection: $selectedOnboarding) {
                    ForEach(Onboarding.allCases, id: \.self) { onboarding in
                        OnboardingPageView(
                            nowOnboard: onboarding,
                            selectedOnboarding: selectedOnboarding
                        )
                        .tag(onboarding)
                    }
                }
                .ignoresSafeArea()
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            }
            
            // Indicator
            VStack {
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(Onboarding.allCases, id: \.self) { onboarding in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(selectedOnboarding == onboarding ? .sgmBlue1 : .sgmBlue1.opacity(0.3))
                            .opacity(selectedOnboarding == .fourth ? 0 : 1)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
