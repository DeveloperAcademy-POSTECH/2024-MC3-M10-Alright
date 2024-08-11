//
//  FourthOnboardingPageView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct OnboardingPageView: View {
    
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isFirstOnboarding") var isFirstOnboarding: Bool?
    
    var nowOnboard: Onboarding
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        nowOnboard.onboardingImage
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                }
            
                VStack(spacing: 30) {
                    HStack {
                        Text("\(nowOnboard.onboardingTitle)")
                            .font(.Pretendard.SemiBold.size40)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading)
                            .padding(.top, 30)
                        Spacer()
                    }
                    HStack {
                        Text("\(nowOnboard.onboardingConstants)")
                            .font(.Pretendard.Medium.size20)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading)
                            .lineSpacing(4)
                        Spacer()
                    }
                    Spacer()
                    
                    Button {
                        isFirstOnboarding = false
                        dismiss()
                    } label: {
                        Text(isFirstOnboarding ?? true ? "Alrigt 시작하기" : "확인했어요")
                            .font(.Pretendard.SemiBold.size17)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                LinearGradient(
                                    gradient: .init(colors: [Color(hex: "#394999"),
                                                             Color(hex: "#4C61CC"),
                                                             Color(hex: "#6079FF")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 40)
                            .opacity(nowOnboard == .fourth ? 1 : 0)
                            .disabled(nowOnboard != .fourth)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 316)
                .background(.sgmBlack)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}
