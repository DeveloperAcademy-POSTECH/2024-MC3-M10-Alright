//
//  FourthOnboardingPageView.swift
//  Alright
//
//  Created by 이상도 on 8/9/24.
//

import SwiftUI

struct FourthOnboardingPageView: View {
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Image("OnboardingImage4")
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                }
            
                VStack(spacing: 30) {
                    HStack {
                        Text("백그라운드")
                            .font(.Pretendard.SemiBold.size40)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading)
                            .padding(.top, 30)
                        Spacer()
                    }
                    HStack {
                        Text("Dynamic Island, Live Activity로\n다른 화면을 보며 모니터링 할 수 있어요!")
                            .font(.Pretendard.Medium.size20)
                            .foregroundColor(.sgmWhite)
                            .padding(.leading)
                            .lineSpacing(4)
                        Spacer()
                    }
                    Spacer()
                    
                    Button {
                        isFirstLaunching.toggle()
                    } label: {
                        Text(isFirstLaunching == true ? "확인했어요" : "Alright 시작하기")
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
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 316)
                .background(.sgmBlack)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

//#Preview {
//    FourthOnboardingPageView()
//}
