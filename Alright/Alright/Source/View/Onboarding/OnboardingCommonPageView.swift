//
//  SecondOnboardingPageView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct OnboardingCommonPageView: View {
    
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Image(imageName)
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                }
            
                VStack(spacing: 30) {
                    HStack {
                        Text(title)
                            .font(.Pretendard.SemiBold.size40)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading, 20)
                            .padding(.top, 30)
                        Spacer()
                    }
                    HStack {
                        Text(subtitle)
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
    OnboardingCommonPageView(title: "Alright", subtitle: "설명", imageName: "OnboardingImage1")
}
